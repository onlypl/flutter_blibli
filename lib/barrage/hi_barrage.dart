// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:blibli/barrage/barrage_view_util.dart';
import 'package:blibli/barrage/i_barrage.dart';
import 'package:blibli/barrage/barrage_model.dart';
import 'package:blibli/barrage/hi_socket.dart';
import 'package:blibli/util/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'barrage_item.dart';

enum BarrageStatus { play, pause }

///弹幕组件
class HiBarrage extends StatefulWidget {
  final int lineCount; //行数
  final String vid; //视频ID
  final int speed; //速度
  final double top; //顶部距离
  final bool autoPlay; //是否自动播放
  const HiBarrage({
    super.key,
    this.lineCount = 4,
    required this.vid,
    this.speed = 800,
    this.top = 0,
    this.autoPlay = false,
  });

  @override
  State<HiBarrage> createState() => HiBarrageState();
}

class HiBarrageState extends State<HiBarrage> implements IBarrage {
  late HiSocket _hiSocket;
  late double _height;
  late double _width;
  final List<BarrageItem> _barrageItemList = []; //弹幕Wedget集合
  final List<BarrageModel> _barrageList = []; //弹幕数据模型集合
  int _barrageIndex = 0;
  final Random _random = Random();
  BarrageStatus? _barrageStatus;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _hiSocket = HiSocket();
    _hiSocket.open(widget.vid).listen((value) {
      _handleMessage(value);
    });
  }

  @override
  void dispose() {
      _hiSocket.close();
      _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = ScreenUtil().screenWidth;
    _height = _width / 16 * 9;
    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        children: [
           //防止Stack的child为空
          Container(),
        ]..addAll(_barrageItemList),
      ),
    );
  }

  //处理消息 instant = true 马上发送
  void _handleMessage(List<BarrageModel> modelList, {bool instant = false}) {
    if (instant) {
      _barrageList.insertAll(0, modelList);
    } else {
      _barrageList.addAll(modelList);
    }

    //收到新的弹幕后播放
    if (_barrageStatus == BarrageStatus.play) {
      play();
      return;
    }
    //如果是自动播放并且不是播放状态
    if (widget.autoPlay && _barrageStatus != BarrageStatus.pause) {
      play();
    }
  }
//播放
  @override
  void play() {
    _barrageStatus = BarrageStatus.play;
    Log().info('播放弹幕');
    if (_timer != null && (_timer?.isActive ?? false)) return;
    //每间隔一段时间发送一次弹幕
    _timer = Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      Log().info('启动发送弹幕');
      if (_barrageList.isNotEmpty) {
        //将取出发送的弹幕并从集合中移除
        var temp = _barrageList.removeAt(0);
        addBarrage(temp);
        Log().info('发送弹幕:${temp.content}');
      } else {
        //弹幕没有数据了,关闭定时器
         Log().info('弹幕没有数据了,关闭定时器');
        _timer?.cancel();
      }
    });
  }

//添加弹幕
  void addBarrage(BarrageModel tempModel) {
    double preRowHeight = 30;
    var line = _barrageIndex % widget.lineCount;
    _barrageIndex++;
    var top = line * preRowHeight + widget.top;
    String id = '${_random.nextInt(10000)}:${tempModel.content}';
    var item = BarrageItem(
      id: id,
      top: top,
      child: BarrageViewUtil.barrageView(tempModel),
      onComplete:_onComplete,
    );
    _barrageItemList.add(item);
    setState(() {
      
    });
  }
 /// 暂停
  @override
  void pause() {
    _barrageStatus = BarrageStatus.pause; //状态改变
    _barrageItemList.clear(); //清除屏幕弹幕
    setState(() {});
    Log().info('暂停发送弹幕');
    _timer?.cancel(); //关闭定时器
  }

  @override
  void send(String? message) {
    if (message == null) return;
    _hiSocket.send(message);
    _handleMessage(
        [BarrageModel(content: message, vid: '-1', priority: 1, type: 1)]);
  }
  //
  void _onComplete(id) {
    Log().info('播放完毕:$id');
    //弹幕播放完毕将其从弹幕widget集合中删除
    _barrageItemList.removeWhere((element) => element.id == id);
  }
}
