// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';

import '../util/color.dart';
//分类切换组件
class HiTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final double fontSize;
  final double boderWidth;
  final double insets;
  final Color unselectedLabelColor;
   const HiTab(
      this.tabs,{
       super.key,
        this.controller,
        this.fontSize = 16,
        this.boderWidth = 0,
        this.insets = 0,
        this.unselectedLabelColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: controller,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        labelColor:primary ,
        unselectedLabelColor:unselectedLabelColor ,
        labelStyle: TextStyle(fontSize: fontSize),
        indicator:  UnderlineIndicator(
          strokeCap: StrokeCap.round,
          borderSide: BorderSide(color: primary, width: boderWidth),
               insets: EdgeInsets.only(left: insets, right: insets),
        ),
        tabs: tabs
        );
  }
}
