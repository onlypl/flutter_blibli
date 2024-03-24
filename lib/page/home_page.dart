// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_unnecessary_containers, avoid_print
import 'package:blibli/http/core/hi_error.dart';
import 'package:blibli/http/core/hi_state.dart';
import 'package:blibli/http/dao/home_dao.dart';
import 'package:blibli/model/home_mo.dart';
import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/page/home_tab_page.dart';
import 'package:blibli/util/color.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:underline_indicator/underline_indicator.dart';

//首页
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
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
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      print("home:${current.page}");
      print("home_pre:${pre.page}");
      if (widget == current.page || current.page is HomePage) {
        print('首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页:onPause');
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
        appBar: null,
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 40),
              child: _tabBar(),
            ),
            Flexible(
                child: TabBarView(
              controller: _controller,
              children: categoryList.map((mo) {
                return HomTabPage(name: mo.name,bannerList:mo.name == '推荐'?bannerList:[]);
              }).toList(),
            )),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;

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
      });
    } on NeedAuth catch (e) {
      Logger().e(e);
    } on NeedLogin catch (e) {
      Logger().e(e);
    } catch (e) {
      Logger().e(e);
    }
  }
}
