// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_unnecessary_containers, avoid_print
import 'dart:ffi';

import 'package:blibli/util/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/web.dart';
import 'package:underline_indicator/underline_indicator.dart';

import 'package:blibli/http/core/hi_error.dart';
import 'package:blibli/http/core/hi_state.dart';
import 'package:blibli/http/dao/home_dao.dart';
import 'package:blibli/model/home_mo.dart';
import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/page/home_tab_page.dart';
import 'package:blibli/util/color.dart';
import 'package:blibli/widget/navigantion_bar.dart';

import '../widget/loading_container.dart';

//首页
class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;
  const HomePage({
    super.key,
    this.onJumpTo,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  TabController? _controller;

  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];
  bool _isloading = true;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      Log().info("home:${current.page}");
      Log().info("home_pre:${pre.page}");
      if (widget == current.page || current.page is HomePage) {
        Log().info('首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        Log().info('首页:onPause');
      }
    });
    loadData();
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        // appBar: null,
        body: LoadingContainer(
        //  cover: true,
          isLoading: _isloading,
          child: Column(
          children: [
          BLNavigationBar( //沉侵导航栏
            height: 50,
            child: _appBar(),
            color: primary,
            statusStyle: StatusStyle.LIGHT_CONTENT,
          ),
          Container(//顶部选项卡容器
            color: Colors.white,
            child: _tabBar(),
          ),
          Flexible(//子控件TabBarView充满父控件
              child: TabBarView(
            controller: _controller,
            children: categoryList.map((mo) {
              return HomTabPage(
                  categoryName: mo.name, bannerList: mo.name == '推荐' ? bannerList : null);
            }).toList(),
          )),
                ],
              ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
  //顶部分类选项卡
  _tabBar() {
    return TabBar(
        controller: _controller,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        labelColor: Colors.black,
        indicator: const UnderlineIndicator(
          strokeCap: StrokeCap.round,
          borderSide: BorderSide(color: primary, width: 3),
          //     insets: EdgeInsets.only(left: 15, right: 15),
        ),
        tabs: categoryList.map<Tab>(
          (mo) {
            return Tab(
                child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                mo.name ?? "",
                style: const TextStyle(fontSize: 16),
              ),
            ));
          },
        ).toList());
  }

  ///获取顶部分类选项卡数据
  void loadData() async {
    try {
      HomeMo result = await HomeDao.get('推荐');
      if (result.categoryList != null) {
        _controller = TabController(
            length: result.categoryList?.length ?? 0, vsync: this);
      }
      setState(() {
        categoryList = result.categoryList ?? [];
        bannerList = result.bannerList ?? [];
        _isloading = false;
      });
    } on NeedAuth catch (e) {
      Log().error(e);
       _isloading = false;
    } on NeedLogin catch (e) {
      Log().error(e);
       _isloading = false;
    } catch (e) {
      Log().error(e);
       _isloading = false;
    }
  }

  ///导航栏
  _appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: const Image(
                  height: 46,
                  width: 46,
                  image: AssetImage("assets/images/avatar.png")),
            ),
          ),
          Expanded(
            //填充剩余空间
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 32,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const Icon(
            Icons.explore_outlined,
            color: Colors.white,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.mail_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
