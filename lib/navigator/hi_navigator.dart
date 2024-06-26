// ignore_for_file: prefer_conditional_assignment, collection_methods_unrelated_type, avoid_print

import 'package:blibli/navigator/bottom_navigator.dart';
import 'package:blibli/page/dark_mode_page.dart';
import 'package:blibli/page/login_page.dart';
import 'package:blibli/page/registration_page.dart';
import 'package:blibli/page/video_detail_page.dart';
import 'package:flutter/material.dart';

import 'package:hi_base/log.dart';

typedef RouteChangeListener = Function(RouteStatusInfo current, RouteStatusInfo pre);

/// 创建页面
MaterialPage pageWrap(Widget child) {
  return MaterialPage(
    key: ValueKey(child.hashCode),
    child: child,
  );
}

///获取routeStatus在页面栈中的位置
int getpageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

///定义路由封装 路由状态
enum RouteStatus {
  login,
  registration,
  home,
  detail,
  darkModel,
  unknown
}

///获取page对应的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  }else if (page.child is DarkModelPage) {
    return RouteStatus.darkModel;
  }
  
  return RouteStatus.unknown;
}

///路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

//监听路由页面跳转
//感知当前页面是否压后台
class HiNavigator extends _RouteJumpListener {
  //单例
  static HiNavigator? _instance;
  RouteJumpListener? _routeJump;
  final List<RouteChangeListener> _listeners = [];
  HiNavigator._();
  RouteStatusInfo? _current;
  //首页底部tab
  RouteStatusInfo? _bottomTab;
  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }
    return _instance!;
  }

  RouteStatusInfo? getCurrent() {
    return _current;
  }

  ///首页底部tab切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  /// 注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    _routeJump = routeJumpListener;
  }

  ///监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  ///移除监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJump?.onJumpTo(routeStatus, args: args);
  }

  //通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      //如果打开的是首页,则明确到首页具体的tab
      current = _bottomTab!;
    }
    Log().info("hi_Navigator:current:${current.page}");
    Log().info("hi_Navigator:pre:${_current?.page}");
     for (var listener in _listeners) {
      listener(current, _current!);
    }
    _current = current;
    
    // _listeners.forEach((listener) {
    //   listener(current,
    //       _current ?? RouteStatusInfo(RouteStatus.unknown, const Center()));
    // });
    // _current = current;
  }

  // Future<bool> openH5(String url) async{
  //   var result = await canLaunch(url);
  //   if(result){
  //       return await launch(url);
  //   }else{
  //     return Future.value(false);
  //   }
  // }
}

///抽象类 提供HiNavigator实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

class RouteJumpListener {
  final OnJumpTo onJumpTo;
  RouteJumpListener({required this.onJumpTo});
}
