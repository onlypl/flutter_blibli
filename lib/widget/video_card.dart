// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/util/format_util.dart';
import 'package:blibli/util/view_util.dart';
import 'package:flutter/material.dart';

import 'package:blibli/model/home_mo.dart';
import '../util/log.dart';

class VideoCard extends StatelessWidget {
  final VideoMo videoMo;
  const VideoCard({
    super.key,
    required this.videoMo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Log().info(videoMo.url);
        HiNavigator.getInstance().onJumpTo(RouteStatus.detail,args: {"videoMo":videoMo});
      },
      child: SizedBox(
        height: 200,
        child: Card(
          margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
          child: ClipRRect(//圆角
            borderRadius: BorderRadius.circular(5),
            child: Column(//垂直布局 图和信息
              children: [
                _itemImage(context),
                _infoText(
                    videoMo.title, videoMo.owner?.face, videoMo.owner?.name),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///视频图片播放量 喜欢数 时间控件
  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        cachedImage(videoMo.cover ?? "",
        width: (size.width - 30) / 2,
        height: 120
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 5, top: 5),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                //渐变 从底部开始到 头部结束
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black87, Colors.black38, Colors.transparent],
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconText(Icons.ondemand_video, videoMo.view),
                  _iconText(Icons.favorite_border, videoMo.favorite),
                  _iconText(null, videoMo.duration),
                ],
              ),
            )),
      ],
    );
  }

  ///播放量 喜欢数 时间控件
  _iconText(IconData? icon, int? num) {
    String countStr = "";
    if (icon != null) {
      countStr = countFormat(num ?? 0);
    } else {
      countStr = durationTransForm(num ?? 0, false);
    }
    return Row(
      children: [
        if (icon != null) Icon(icon, color: Colors.white, size: 12),
        Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Text(countStr,
              style: const TextStyle(color: Colors.white, fontSize: 10)),
        ),
      ],
    );
  }

  ///视频信息
  _infoText(String? title, String? url, String? name) {
    return Expanded(
        //填充剩余
        child: Container(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5), //整体间距
      child: Column(
        //垂直布局
        crossAxisAlignment: CrossAxisAlignment.start, //交叉轴靠左显示
        mainAxisAlignment: MainAxisAlignment.spaceBetween, //主轴 图上 信息下
        children: [
          Text(
            title ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis, //无法显示则显示...
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          _owner(url, name) //用户信息
        ],
      ),
    ));
  }

  ///头像+用户名信息+更多按钮
  _owner(String? url, String? name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, //头像+用户名 和 更多 各两边
      children: [
        Row(
          //头像+用户名
          children: [
            ClipRRect(
              //头像
              borderRadius: BorderRadius.circular(12),
              child: cachedImage(url ?? '', width: 24,height: 24),
            ),
            Padding(
              //用户名
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                name ?? "",
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            )
          ],
        ),
        const Icon(
          //更多图标
          Icons.more_vert_sharp,
          size: 15,
          color: Colors.grey,
        ),
      ],
    );
  }
}
