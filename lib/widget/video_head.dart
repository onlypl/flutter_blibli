// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:blibli/util/color.dart';
import 'package:blibli/util/format_util.dart';

import '../model/video_model.dart';

//详情页 作者信息组件
class VideoHead extends StatelessWidget {
  final Owner? owner;
  final VoidCallback? onFacePressed;
  
  const VideoHead({
    super.key,
    required this.owner,
    this.onFacePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _userInfo(),
          MaterialButton(
            onPressed:onFacePressed ?? (){},
            color: primary,
            height: 30,
            minWidth: 50,
            child: const Text(
              '+ 关注',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

///用户信息
  Row _userInfo() {
    return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(owner?.face ?? "", width: 30, height: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    owner?.name ?? '',
                    style: const TextStyle(
                        fontSize: 13,
                        color: primary,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${countFormat(owner?.fans ?? 0)}粉丝',
                    style: const TextStyle(fontSize: 10, color: Colors.green),
                  )
                ],
              ),
            ),
          ],
        );
  }
}
