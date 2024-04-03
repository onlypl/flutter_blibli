import 'package:blibli/model/video_model.dart';
import 'package:blibli/navigator/hi_navigator.dart';
import 'package:hi_base/format_util.dart';
import 'package:blibli/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/view_util.dart';
///关联视频 视频列表卡片
class VideoLargeCard extends StatelessWidget {
  final VideoModel videoModel;
  const VideoLargeCard({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HiNavigator.getInstance()
            .onJumpTo(RouteStatus.detail, args: {"videoModel": videoModel});
      },
      child: Container(
        margin:const EdgeInsets.fromLTRB(15, 0, 15, 5),
        padding:const EdgeInsets.only(bottom: 6),
        height: 106,
        decoration:BoxDecoration(border: borderLine(context)) ,
        child: Row(
          children: [_itemImage(context), _buildContent()],
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    double height = 90;
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Stack(
        children: [
          cachedImage(videoModel.cover ?? '',
              width: height * 16 / 9, height: height),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                  durationTransForm(videoModel.duration ?? 0, true),
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }

  _buildContent() {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.only(top: 5, left: 9, bottom: 5,right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            videoModel.title ?? '',
            maxLines: 2,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
          _buildBottomContent(),
        ],
      ),
    ));
  }

  _buildBottomContent() {
    return Column(
      children: [
        //作者
        _owner(),
        hiSpace(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ...smallIconText(Icons.ondemand_video, videoModel.view),
                hiSpace(width: 5),
                ...smallIconText(Icons.list_alt, videoModel.reply),
              ],
            ),
            const Icon(
              Icons.more_vert_sharp,
              color: Colors.grey,
              size: 15,
            )
          ],
        )
      ],
    );
  }

  ///作者
  _owner() {
    var owner = videoModel.owner;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 2, right: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: Colors.grey),
          ),
          child: const Text('UP',
              style: TextStyle(
                  fontSize: 8,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold)),
        ),
        hiSpace(width: 8),
        Text(
          owner?.name ?? '',
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }
}
