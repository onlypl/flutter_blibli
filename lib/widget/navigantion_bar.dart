
import 'package:blibli/util/view_util.dart';
import 'package:flutter/material.dart';
enum  StatusStyle { LIGHT_CONTENT,DARK_CONTENT}
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
  @override
  void initState() {
    super.initState();
    _statusBarInit();
  }
  @override
  Widget build(BuildContext context) {
    //状态栏高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: widget.color),
      child: widget.child,
    );
  }

  void _statusBarInit() {
    //设置沉侵状态栏
   changeStatusBar(color: widget.color,statusStyle: widget.statusStyle);
  }
}
