import 'package:blibli/http/core/hi_base_tab_state.dart';
import 'package:blibli/http/dao/ranking_dao.dart';
import 'package:blibli/model/ranking_model.dart';
import 'package:blibli/page/ranking_tab_page.dart';
import 'package:blibli/util/view_util.dart';
import 'package:blibli/widget/hi_tab.dart';
import 'package:blibli/widget/navigantion_bar.dart';
import 'package:blibli/widget/video_large_card.dart';
import 'package:flutter/material.dart';

//排行榜
class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with TickerProviderStateMixin {
  static const tabList = [
    {"key": "like", "name": "最热"},
    {"key": "pubdate", "name": "最新"},
    {"key": "favorite", "name": "收藏"},
  ];
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabList.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildNavigationBar(),
          _buildTabView(),
        ],
      ),
    );
  }

  _buildNavigationBar() {
    return BLNavigationBar(
      child: Container(
        alignment: Alignment.center,
        child: _tabbar(),
        decoration: bottomBoxShadow(),
      ),
    );
  }

  //分类选项卡
  _tabbar() {
    return HiTab(
      tabList.map<Tab>((tab) {
        return Tab(
          text: tab['name'],
        );
      }).toList(),
      fontSize: 16,
      boderWidth: 3,
      unselectedLabelColor: Colors.black54,
      controller: _controller,
      tabAlignment: TabAlignment.center,
    );
  }
  //对应的子页面
  _buildTabView() {
    return Flexible(
        child: TabBarView(
      controller: _controller,
      children: tabList.map<Widget>((tab){
        return RankingTabPage(sort: tab['key']!);
      }).toList(),
    ));
  }
}
