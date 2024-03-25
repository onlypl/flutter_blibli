// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blibli/util/color.dart';
import 'package:flutter/material.dart';
import 'package:status_bar_control/status_bar_control.dart';

// ignore: constant_identifier_names
enum  StatusStyle { LIGHT_CONTENT,DARK_CONTENT}
class BLNavigationBar extends StatelessWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;
  const BLNavigationBar({
    super.key,
    this.statusStyle = StatusStyle.DARK_CONTENT,
    this.color = Colors.white,
    this.height = 46,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    _statusBarInit();
    //状态栏高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + height,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: color),
      child: child,
    );
  }

  void _statusBarInit() {
    //设置沉侵状态栏
    StatusBarControl.setColor(primary, animated: true);
    StatusBarControl.setStyle(statusStyle == StatusStyle.DARK_CONTENT
        ? StatusBarStyle.DARK_CONTENT
        : StatusBarStyle.LIGHT_CONTENT);
  }
}
