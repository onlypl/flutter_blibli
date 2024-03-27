// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';

import 'package:blibli/model/home_mo.dart';
import 'package:blibli/util/view_util.dart';
import 'package:blibli/widget/appbar.dart';
import 'package:blibli/widget/hi_tab.dart';
import 'package:blibli/widget/navigantion_bar.dart';
import 'package:blibli/widget/video_view.dart';
import 'package:flutter/material.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoMo videoMo;
  const VideoDetailPage(this.videoMo, {super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List tabs = ["简介", "评论2888"];
  @override
  void initState() {
    super.initState();
    //黑色状态栏 仅安卓
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
    _tabController = TabController(length: tabs.length, vsync: this);
  }
@override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            BLNavigationBar(
              color: Colors.black,
              statusStyle: StatusStyle.DARK_CONTENT,
              height: Platform.isAndroid ? 0 : 0,
            ),
            _buildVideoView(),
           _buildTabNavigation(),
          ],
        ),
      ),
    );
  }

  //视频组件
  _buildVideoView() {
    var model = widget.videoMo;
    return VideoView(
      url: model.url ?? "",
      cover: model.cover,
      overlayUI: videoAppBar(),
    );
  }

  //分类选项卡
  _buildTabNavigation() {
    return Material(
      elevation:2,
      shadowColor: Colors.grey[100],
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.live_tv_rounded,color: Colors.grey,size: 20,),
            ),
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      tabs.map<Tab>((name) {
          return Tab(
                child: Padding(padding: const EdgeInsets.only(left: 0),
                child:Text(
                  name,
                  style: const TextStyle(fontSize: 16),
                ),
                ),
                 
          );
      }).toList(),
      controller: _tabController,
      unselectedLabelColor: Colors.grey,
      boderWidth: 3,
      insets: 0,
    );
  }
}