// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:blibli/db/hi_cache.dart';
import 'package:hi_base/color.dart';
import 'package:blibli/util/hi_constants.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['system', 'Light', 'Dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode? _themeMode;
  Brightness? _platformBrightness;
  // BuildContext? context;
  // ThemeProvider({
  //   this.context,
  // }) {
  //   if (context != null) {
  //     _platformBrightness = MediaQuery.of(context!).platformBrightness;
  //   }
  // }

  /// 系统Dark Mode发生变化
  void darModeChange(BuildContext? context) {
    if (context != null) {
      if(_platformBrightness == null){
          _platformBrightness = MediaQuery.of(context).platformBrightness;
          notifyListeners();
          return;
      }

      if (_platformBrightness != MediaQuery.of(context).platformBrightness) {
        _platformBrightness = MediaQuery.of(context).platformBrightness;
        notifyListeners();
      }
    }
  }

  ///是否是Dark模式
  bool isDark(BuildContext? context) {
    if (_themeMode == ThemeMode.system && context != null) {
      //获取系统的darkmode
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  //获取主题模式
  ThemeMode getThemeMode() {
    String? theme = HiCache.getInstance().get(HiConstants.theme);
    switch (theme) {
      case 'Dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'System':
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode!;
  }

  //设置主题
  void setTheme(ThemeMode themeMode) {
    HiCache.getInstance().setString(HiConstants.theme, themeMode.value);
    notifyListeners();
  }

  ///获取主题
  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? HiColor.darkBg : HiColor.bg,
      scaffoldBackgroundColor: isDarkMode ? HiColor.darkBg : HiColor.bg, //页面背景
      indicatorColor: isDarkMode ? white : primary[50]!, //指示器
      colorScheme: ColorScheme(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primary: isDarkMode ? HiColor.darkBg : HiColor.bg,
        onPrimary: isDarkMode ? primary[50]! : primary[50]!,
        secondary: isDarkMode ? white : primary,
        onSecondary: isDarkMode ? white : primary,
        error: isDarkMode ? HiColor.darkRed : HiColor.red,
        onError: isDarkMode ? HiColor.darkRed : HiColor.red,
        background: isDarkMode ? HiColor.darkBg : HiColor.bg,
        onBackground: isDarkMode ? HiColor.darkBg : HiColor.bg,
        surface: isDarkMode ? white : Colors.black,
        onSurface: isDarkMode ? white : Colors.black,
      ),
      cardTheme: CardTheme(
        color: isDarkMode ? Colors.black12 : white,
      ),

      cardColor: isDarkMode ? Colors.black26 : white,
    );
    return themeData;
  }
}
