import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/log.dart';

class HiDefend {
  run(Widget app) {
    //框架异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      //线上环境,走上报逻辑
      if (kReleaseMode) {
        Zone.current.handleUncaughtError(
            details.exception, details.stack ?? StackTrace.fromString('未知异常'));
      } else {
        //开发期间,走Console抛出
        FlutterError.dumpErrorToConsole(details);
      }
    };
    runZonedGuarded(() {
      runApp(app);
    }, (error, stack) {
      _reportError(error, stack);
    });
  }

  ///通过接口上报异常
  void _reportError(Object error, StackTrace stack) {
    Log().error('kReleaseMode:$kReleaseMode');
    Log().error('catch error:$error');
  }
}
