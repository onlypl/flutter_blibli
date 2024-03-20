// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'package:blibli/model/video_model.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;
 const VideoDetailPage(this.videoModel, {Key? key}) : super(key: key);

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child:Text('视频详情页,vid:${widget.videoModel.vid}'),
      ),
    );
  }
}