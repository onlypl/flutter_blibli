// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';
import 'package:blibli/barrage/barrage_input.dart';
import 'package:blibli/barrage/barrage_switch.dart';
import 'package:blibli/barrage/hi_barrage.dart';
import 'package:blibli/http/dao/favorrite_dao.dart';
import 'package:blibli/http/dao/video_detail_dao.dart';
import 'package:blibli/model/video_detail_model.dart';
import 'package:blibli/util/log.dart';
import 'package:blibli/util/toast.dart';
import 'package:blibli/util/view_util.dart';
import 'package:blibli/widget/appbar.dart';
import 'package:blibli/widget/expandable_content.dart';
import 'package:blibli/widget/hi_tab.dart';
import 'package:blibli/widget/navigantion_bar.dart';
import 'package:blibli/widget/video_head.dart';
import 'package:blibli/widget/video_large_card.dart';
import 'package:blibli/widget/video_tool_bar.dart';
import 'package:blibli/widget/video_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay/flutter_overlay.dart';
import 'package:hi_net/core/hi_error.dart';
import '../model/video_model.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;
  const VideoDetailPage(this.videoModel, {super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List tabs = ["简介", "评论2888"];
  VideoDetailModel videoDetailMo = VideoDetailModel();
  late VideoModel videoModel;
  List<VideoModel> videoList = [];
  final _barrageKey = GlobalKey<HiBarrageState>();
  bool _inoutShowing = false;
  @override
  void initState() {
    super.initState();

    //黑色状态栏 仅安卓
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
    _tabController = TabController(length: tabs.length, vsync: this);
    videoModel = widget.videoModel;
    _loadDetail();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: videoModel.url != null
          ? Container(
              child: Column(
                children: [
                  BLNavigationBar(
                    color: Colors.black,
                    statusStyle: StatusStyle.DARK_CONTENT,
                    height: Platform.isAndroid ? 0 : 0,
                  ),
                  _buildVideoView(),
                  _buildTabNavigation(),
                  Flexible(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildDetailList(),
                        Container(
                          child: const Text('尽情期待'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  //视频组件
  _buildVideoView() {
    var model = videoModel;
    return VideoView(
      url: model.url ?? "",
      cover: model.cover,
      overlayUI: videoAppBar(),
      barrageUI: HiBarrage(
        key: _barrageKey,
        vid: model.vid ?? '',
        autoPlay: true,
      ),
    );
  }

  //分类选项卡
  _buildTabNavigation() {
    return Material(
      elevation: 2,
      shadowColor: Colors.grey[100],
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_tabBar(), _buildBarrageBtn()],
        ),
      ),
    );
  }

//简介 评论分类选项卡item
  _tabBar() {
    return HiTab(
      tabs.map<Tab>((name) {
        return Tab(
          child: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        );
      }).toList(),
      controller: _tabController,
      unselectedLabelColor: Colors.grey,
      boderWidth: 3,
      insets: 0,
    );
  }

  //详情信息和列表
  _buildDetailList() {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        ...buildCotents(),
        ...buildVideoList(),
      ],
    );
  }

//视频发布者的用户信息 关注 展开信息 点赞 不喜欢 收藏 分享等工具栏
  buildCotents() {
    return [
      //
      VideoHead(owner: videoModel.owner),
      ExpandableContent(mo: videoModel),
      VideoToolBar(
        detailMo: videoDetailMo,
        videoModel: videoModel,
        onLike: _doLike,
        onUnLike: _onUnLike,
        onFavorite: _onFavorite,
        onShare: _onShare,
      ),
    ];
  }

  //加载详情数据
  void _loadDetail() async {
    try {
      VideoDetailModel result = await VideoDetailDao.get(videoModel.vid ?? '');
      setState(() {
        videoDetailMo = result;
        if (videoDetailMo.videoInfo != null) {
          videoModel = videoDetailMo.videoInfo ?? VideoModel();
          videoList = videoDetailMo.videoList ?? [];
        }
      });
    } on NeedLogin catch (e) {
      Log().error(e);
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      Log().error(e);
      showWarnToast(e.message);
    } catch (e) {
      Log().error(e.toString());
    }
  }

  ///点赞
  void _doLike() {}

  ///踩
  void _onUnLike() {}

  ///收藏
  void _onFavorite() async {
    try {
      Log().debug('!!!!!!!${!(videoDetailMo.isFavorite ?? false)}');
      var result = await FavorriteDao.favorite(
          videoModel.vid ?? '', !(videoDetailMo.isFavorite ?? false));
      if (result["code"] == 0) {
        Log().info('收藏/取消收藏成功');
        setState(() {
          videoDetailMo.isFavorite = !(videoDetailMo.isFavorite ?? false);
          if (videoDetailMo.isFavorite!) {
            videoModel.favorite = (videoModel.favorite ?? 0) + 1;
          } else {
            videoModel.favorite = (videoModel.favorite ?? 0) - 1;
          }
        });
        showToast(videoDetailMo.isFavorite! ? '已收藏' : '已取消收藏');
      } else {
        Log().info(result['msg']);
        showWarnToast(result['msg']);
      }
    } on NeedLogin catch (e) {
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    }
  }

  ///分享
  void _onShare() {}

  //视频列表
  buildVideoList() {
    return videoList
        .map((VideoModel model) => VideoLargeCard(videoModel: model));
  }

  ///弹幕发送按钮
  _buildBarrageBtn() {
    return BarrageSwitch(
        inoutShowing: _inoutShowing,
        initSwitch: true,
        onShowInput: () {
          setState(() {
            _inoutShowing = true;
            HiOverlay.show(context, child: BarrageInput(
              onTabClose: () {
                setState(() {
                  _inoutShowing = false;
                });
              },
            )).then((value) {
              Log().info('---输入的弹幕内容:$value');
              _barrageKey.currentState?.send(value);
            });
          });
        },
        onBarrageSwitch: (open) {
          if (open) {
            _barrageKey.currentState?.play();
          } else {
            _barrageKey.currentState?.pause();
          }
        });
  }
}
