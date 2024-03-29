// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blibli/util/color.dart';
import 'package:blibli/util/format_util.dart';
import 'package:blibli/util/view_util.dart';
import 'package:flutter/material.dart';

import 'package:blibli/model/video_detail_model.dart';

import '../model/video_model.dart';

///视频点赞分享收藏等工具栏
class VideoToolBar extends StatefulWidget {
  final VideoDetailModel detailMo;
  final VideoModel videoModel;
  final VoidCallback? onLike;
  final VoidCallback? onUnLike;
  final VoidCallback? onCoin;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;
  const VideoToolBar({
    super.key,
    required this.detailMo,
    required this.videoModel,
    this.onLike,
    this.onUnLike,
    this.onCoin,
    this.onFavorite,
    this.onShare,
  });

  @override
  State<VideoToolBar> createState() => _VideoToolBarState();
}

class _VideoToolBarState extends State<VideoToolBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: borderLine(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText(Icons.thumb_up_alt_rounded, widget.videoModel.like,
              onClick: widget.onLike, tint: widget.detailMo.isLike ?? false),
          _buildIconText(Icons.thumb_down_alt_rounded, '不喜欢',
              onClick: widget.onUnLike),
          _buildIconText(Icons.monetization_on, widget.videoModel.coin,
              onClick: widget.onCoin),
          _buildIconText(Icons.grade_rounded, widget.videoModel.favorite,
              onClick: widget.onFavorite, tint: widget.detailMo.isFavorite ?? false),
          _buildIconText(Icons.share_rounded, widget.videoModel.share,
              onClick: widget.onShare),
        ],
      ),
    );
  }

  _buildIconText(IconData iconData, text,
      {VoidCallback? onClick, bool tint = false}) {
    if (text is int) {
      text = countFormat(text);
    } else {
      text ??= '';
    }
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Icon(iconData, color: tint ? primary : Colors.grey, size: 20),
          hiSpace(height: 5),
          Text(
            text,
            style: TextStyle(color: tint ? primary : Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
