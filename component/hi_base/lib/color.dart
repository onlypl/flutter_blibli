import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

//主色调
const MaterialColor primary =
    MaterialColor(0xfffb7299, <int, Color>{50: Color(0xffff9db5)});

const MaterialColor white = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

///随机色
Color randomColor() {
  return Color.fromARGB(
    255, // 不透明度（0到255）
    Random().nextInt(255), // 红色（0到255）
    Random().nextInt(255), // 绿色（0到255）
    Random().nextInt(255), // 蓝色（0到255）
  );
}

class HiColor {
  static const Color red = Color(0xFFFF4759);
  static const Color darkRed = Color(0xFFE03E4E);


  static const Color bg = Color(0xFFFFFFFF);
  static const Color darkBg = Color(0xFF18191A);

  //根据主题设置颜色
  Color themeColor(bool isDark,darkColor,lightColor){
    return isDark? darkColor:lightColor;
  }
}
