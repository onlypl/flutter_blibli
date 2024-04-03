import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/page/profile_page.dart';
import 'package:blibli/page/video_detail_page.dart';
import 'package:hi_base/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_bar_control/status_bar_control.dart';
import '../provider/theme_provider.dart';
import '../widget/navigantion_bar.dart';

///设置沉侵状态栏
void changeStatusBar(
    {color = Colors.white,
    StatusStyle statusStyle = StatusStyle.DARK_CONTENT,
    BuildContext? context}) {
  if (context != null) {
    var themeProvider = context.watch<ThemeProvider>();
    if (themeProvider.isDark(context)) {
      statusStyle = StatusStyle.LIGHT_CONTENT;
      color = HiColor.darkBg;
    } else {
      statusStyle = StatusStyle.DARK_CONTENT;
    }
  }
  var page = HiNavigator.getInstance().getCurrent()?.page;
  //fix android切换 profile页面状态变白问题
  if (page is ProfilePage) {
    color = Colors.transparent;
  } else if (page is VideoDetailPage) {
    color = HiColor.darkBg;
    statusStyle = StatusStyle.LIGHT_CONTENT;
  }
  StatusBarControl.setColor(color, animated: false);
  StatusBarControl.setStyle(statusStyle == StatusStyle.DARK_CONTENT
      ? StatusBarStyle.DARK_CONTENT
      : StatusBarStyle.LIGHT_CONTENT);
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

///底部阴影
BoxDecoration? bottomBoxShadow(BuildContext context) {
  ThemeProvider themeProvider = context.watch();
  if (themeProvider.isDark(context)) {
    return null;
  }
  return BoxDecoration(color: Colors.white, boxShadow: [
    BoxShadow(
        offset: const Offset(0, 5), //xy轴偏移量
        color: (Colors.grey[100])!,
        blurRadius: 5, //阴影 模糊程度
        spreadRadius: 1 //阴影扩散程度
        )
  ]);
}
