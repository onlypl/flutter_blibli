
import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/page/profile_page.dart';
import 'package:blibli/page/video_detail_page.dart';
import 'package:blibli/util/color.dart';
import 'package:blibli/util/format_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_bar_control/status_bar_control.dart';

import '../provider/theme_provider.dart';
import '../widget/navigantion_bar.dart';
import 'esoImage_cache_manager.dart';

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

///设置沉侵状态栏
void changeStatusBar(
    {color = Colors.white,
    StatusStyle statusStyle = StatusStyle.DARK_CONTENT,BuildContext? context}) {
      if(context !=null){
          var themeProvider = context.watch<ThemeProvider>();
          if(themeProvider.isDark(context)){
            statusStyle =  StatusStyle.LIGHT_CONTENT;
            color = HiColor.darkBg;
          }else{
            statusStyle =  StatusStyle.DARK_CONTENT;
          }
      }
     var page = HiNavigator.getInstance().getCurrent()?.page;
     //fix android切换 profile页面状态变白问题
          if(page is ProfilePage){
              color = Colors.transparent;
          }else if(page is VideoDetailPage){
              color = HiColor.darkBg;
             statusStyle = StatusStyle.LIGHT_CONTENT;
          }
  StatusBarControl.setColor(color, animated: false);
  StatusBarControl.setStyle(statusStyle == StatusStyle.DARK_CONTENT
      ? StatusBarStyle.DARK_CONTENT
      : StatusBarStyle.LIGHT_CONTENT);
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

///Border线条
borderLine(BuildContext context,
    {bottom = true, top = false, width = 0.5, color = Colors.grey}) {
  BorderSide borderSide = BorderSide(width: width, color: color);
  return Border(
    bottom: bottom ? borderSide : BorderSide.none,
    top: top ? borderSide : BorderSide.none,
  );
}

///组件间隙
SizedBox hiSpace({double height = 1 ,double width = 1}){
    return SizedBox(
        width: width,
        height: height,
    );
}

///底部阴影
BoxDecoration? bottomBoxShadow(BuildContext context) {
    ThemeProvider themeProvider = context.watch();
    if(themeProvider.isDark(context)){
        return null;
    }
  return BoxDecoration(color:  Colors.white,boxShadow: [
    BoxShadow(
      offset:const Offset(0, 5), //xy轴偏移量
      color: (Colors.grey[100])!,
      blurRadius: 5,  //阴影 模糊程度
      spreadRadius: 1 //阴影扩散程度
    )
  ]);
}