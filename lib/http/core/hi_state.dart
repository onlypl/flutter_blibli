import 'package:flutter/material.dart';
import 'package:logger/web.dart';
//页面状态异常管理
abstract class HiState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    } else {
       Logger().d('HiState:页面已销毁,本次setState不执行${toString()}');
    }
  }
}
