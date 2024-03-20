// ignore_for_file: avoid_print, prefer_is_empty, deprecated_member_use, camel_case_types, prefer_typing_uninitialized_variables

import 'package:blibli/db/hi_cache.dart';
import 'package:blibli/model/video_model.dart';
import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/page/home_page..dart';
import 'package:blibli/page/login_page.dart';
import 'package:blibli/page/video_detail_page.dart';
import 'package:blibli/util/color.dart';
import 'package:blibli/util/toast.dart';
import 'package:flutter/material.dart';

import 'http/dao/login_dao.dart';
import 'page/registration_page.dart';

void main() {
  runApp(const BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({super.key});

  @override
  State<BiliApp> createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  final BiliRouteDelegate _routeDelegate = BiliRouteDelegate();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
        //进行初始化
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(
                  routerDelegate: _routeDelegate,
                )
              : const Scaffold(
                  body: Center(child: CircularProgressIndicator()));

          return MaterialApp(
            home: widget,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: primary, //主题色
              ).copyWith(secondary: Colors.white), //次要颜色
              //   ColorScheme.fromSwatch(
              //   primarySwatch: white
              // ).copyWith(
              //   secondary: Colors.green //次要颜色
              // ),
              //useMaterial3: true,
              appBarTheme: const AppBarTheme(color: white),
            ),
          );
        });
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigationKey;
  //为Navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  BiliRouteDelegate() : navigationKey = GlobalKey<NavigatorState>(){
      //实现路由跳转逻辑
      HiNavigator.getInstance().registerRouteJump(RouteJumpListener(onJumpTo: (routeStatus, {Map? args}) {
        _routeStatus = routeStatus;
        if(routeStatus == RouteStatus.detail){
            videoModel = args!['videoModel'];
        }
        notifyListeners();
      }));
  }
  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  VideoModel? videoModel;
  @override
  Widget build(BuildContext context) {
    var index = getpageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      // 要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      // tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    // 跳转首页时将栈中其它页面进行出栈，因为首页不可回退
    if (routeStatus == RouteStatus.home) {
      pages.clear();
      page = pageWrap(const HomePage());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel ?? VideoModel(vid: -1)));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(const RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(const LoginPage());
    }
    // 重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    //通知路由发生变化
    HiNavigator.getInstance().notify(tempPages,pages);
    pages = tempPages;
    return WillPopScope(
      onWillPop: () async => !await navigationKey.currentState!.maybePop(),
      child:Navigator(
      key: navigationKey,
      pages: pages,
      onPopPage: (route, result) {
        if(route.settings is MaterialPage){
            //登录页未登录返回拦截
            if((route.settings as MaterialPage).child is LoginPage){
                  if(!hasLogin){
                      showToast('请先登录');
                      return false;
                  }
            }
        }
        //执行返回操作
        //在这里可以控制是否可以返回
        if (!route.didPop(result)) {
          return false;
        }
        var tempPages = [...pages];
        pages.removeLast();
        //通知路由发生变化
        HiNavigator.getInstance().notify(pages, tempPages);
        return true;
      },
    ), );
  
  }

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    }
    return _routeStatus;
  }

  //获取令牌是否存在
  bool get hasLogin => LoginDao.getBoardingPass() != null;
  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {}
}

///定义路由数据 path
class BiliRoutePath {
  final String location;
  BiliRoutePath.home() : location = "/";
  BiliRoutePath.detail() : location = "/detail";
}
