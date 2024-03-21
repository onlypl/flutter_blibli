import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/page/favorite_page.dart';
import 'package:blibli/page/home_page..dart';
import 'package:blibli/page/profile_page.dart';
import 'package:blibli/page/ranking_page.dart';
import 'package:blibli/util/color.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = primary;
  int _currentIndex = 0;
  static int initIalPage = 0;
  final PageController _controller = PageController(initialPage: 0);
  List<Widget>? _pages;
  bool _hasBuild = false;
  @override
  Widget build(BuildContext context) {
    _pages = [
      const HomePage(),
      const RankingPage(),
      const FavoritePage(),
      const ProfilePage()
    ];
    if (!_hasBuild) {
      //页面第一次打开时 通知是哪个tab
      HiNavigator.getInstance()
          .onBottomTabChange(initIalPage, _pages![initIalPage]);
      _hasBuild = true;
    }
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pages!,
        onPageChanged:(index) => _onJumpTo(index,pageChange: true),
        physics: const NeverScrollableScrollPhysics(), //禁止滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, //未选中也显示文本
          currentIndex: _currentIndex,
          onTap: _onJumpTo,
          selectedItemColor: _activeColor,
          unselectedItemColor: _defaultColor,
          items: [
            _bottomItem('首页', Icons.home, 0),
            _bottomItem('排行', Icons.local_fire_department, 1),
            _bottomItem('收藏', Icons.favorite, 2),
            _bottomItem('我的', Icons.live_tv, 3),
          ]),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
      label: title,
    );
  }

  void _onJumpTo(int index, {pageChange = false}) {
    if (!pageChange) {
      //让pageView展示对应的tab
      _controller.jumpToPage(index);
    }else{
      HiNavigator.getInstance().onBottomTabChange(index, _pages![index]);
    }

    setState(() {
      _currentIndex = index;
    });
  }
}
