// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_unnecessary_containers, avoid_print
import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/page/home_tab_page.dart';
import 'package:blibli/util/color.dart';
import 'package:flutter/material.dart';

import 'package:blibli/model/video_model.dart';
import 'package:underline_indicator/underline_indicator.dart';

//首页
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  TabController? _controller;
  var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "日常", "综合", "手机游戏", "短片·手书·配音"];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      print("home:${current.page}");
      print("home_pre:${pre.page}");
      if (widget == current.page || current.page is HomePage) {
        print('首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页:onPause');
      }
    });
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: null,
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 30),
              child: _tabBar(),
            ),
            Flexible(child: TabBarView(
              controller: _controller,
              children: tabs.map((tab){
                  return HomTabPage(name: tab);
              }).toList(),
              )
            ),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
        controller: _controller,
        isScrollable: true,
        labelColor: Colors.black,
        indicator: const UnderlineIndicator(
          strokeCap: StrokeCap.round,
          borderSide: BorderSide(color: primary, width: 3),
     //     insets: EdgeInsets.only(left: 15, right: 15),
        ),
        tabs: tabs.map<Tab>(
          (tab) {
            return Tab(
                child: Padding(
             padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                tab,
                style: const TextStyle(fontSize: 16),
              ),
            ));
          },
        ).toList());
  }
}
