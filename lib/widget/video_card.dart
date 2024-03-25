// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:blibli/model/home_mo.dart';
import 'package:logger/web.dart';

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
      },
      child: Image.network(videoMo.cover ?? ""),
    );
  }
}
