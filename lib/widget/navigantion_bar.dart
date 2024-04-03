import 'dart:ui';

import 'package:blibli/provider/theme_provider.dart';
import 'package:hi_base/color.dart';
import 'package:blibli/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class BLNavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;
  const BLNavigationBar({
    super.key,
    this.statusStyle = StatusStyle.DARK_CONTENT,
    this.color = Colors.white,
    this.height = 44,
    this.child,
  });

  @override
  State<BLNavigationBar> createState() => _BLNavigationBarState();
}

class _BLNavigationBarState extends State<BLNavigationBar> {
  late StatusStyle _statusStyle;
  late Color _color;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.watch();
    if (themeProvider.isDark(context)) {
      _color = HiColor.darkBg;
      _statusStyle = StatusStyle.LIGHT_CONTENT;
    } else {
      _color = widget.color;
      _statusStyle = widget.statusStyle;
    }
    _statusBarInit();
    //状态栏高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: _color),
      child: widget.child,
    );
  }

  void _statusBarInit() {
    //设置沉侵状态栏
    changeStatusBar(color: _color, statusStyle: _statusStyle);
  }
}
