
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:status_bar_control/status_bar_control.dart';

import '../widget/navigantion_bar.dart';
///带缓存的image
Widget cachedImage(String imageUrl, {double? width, double? height}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    width: width,
    height: height,
    fit: BoxFit.cover,
    placeholder: (
      BuildContext context,
      String url,
    ) {
      return Container(color: Colors.grey[200]);
    },
    errorWidget: (
      BuildContext context,
      String url,
      Object error,
    ) => const Icon(Icons.error),
  );
}
///黑色线性渐变
blackLinearGradient({bool fromTop = false}){
  return LinearGradient(
    begin: fromTop?Alignment.topCenter:Alignment.bottomCenter,
    end: fromTop?Alignment.bottomCenter:Alignment.topCenter,
    colors: const [
        Colors.black54,
        Colors.black45,
         Colors.black26,
          Colors.black12,
           Colors.transparent,
  ]);
}
   ///设置沉侵状态栏
  void changeStatusBar({color =Colors.white,StatusStyle statusStyle = StatusStyle.DARK_CONTENT}) {
    StatusBarControl.setColor(color, animated: false);
    StatusBarControl.setStyle(statusStyle == StatusStyle.DARK_CONTENT
        ? StatusBarStyle.DARK_CONTENT
        : StatusBarStyle.LIGHT_CONTENT);
  }