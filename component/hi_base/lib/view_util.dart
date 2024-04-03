import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'esoImage_cache_manager.dart';
import 'format_util.dart';

///带缓存的image
Widget cachedImage(String imageUrl, {double? width, double? height}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    cacheManager: EsoImageCacheManager(),
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
    ) =>
        const Icon(Icons.error),
  );
}

///黑色线性渐变
blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
      begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
      colors: const [
        Colors.black54,
        Colors.black45,
        Colors.black26,
        Colors.black12,
        Colors.transparent,
      ]);
}

///带文字的小图标
smallIconText(IconData? iconData, var text,
    {double textLeft = 5,
    Color iconColor = Colors.grey,
    double iconSize = 12,
    TextStyle style = const TextStyle(fontSize: 12, color: Colors.grey)}) {
  if (text is int) {
    text = countFormat(text);
  }

  return [
    if (iconData != null)
      Icon(
        iconData,
        color: iconColor,
        size: iconSize,
      ),
    Padding(
      padding: EdgeInsets.only(left: iconData != null ? textLeft : 0),
      child: Text(text, style: style),
    ),
  ];
}

///组件间隙
SizedBox hiSpace({double height = 1 ,double width = 1}){
    return SizedBox(
        width: width,
        height: height,
    );
}
