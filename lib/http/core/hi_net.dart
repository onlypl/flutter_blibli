// ignore_for_file: avoid_print, prefer_conditional_assignment, prefer_typing_uninitialized_variables

import 'package:blibli/http/core/dio_adapter.dart';
import 'package:blibli/http/core/hi_error.dart';
import 'package:blibli/http/core/hi_net_adapter.dart';
import 'package:blibli/http/core/mock_adapter.dart';
import 'package:blibli/http/request/base_request.dart';

/// 1.支持网络库插拔设计，且不干扰业务层
/// 2.基于配置请求请求，简洁易用
/// 3.Adapter设计，扩展性强
/// 4.统一异常和返回处理
class HiNet {
  HiNet._();
  static HiNet? _instance;
  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;

    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
    } catch (e) {
      error = e;
    }

    var result = response?.data;
    printLog('请求结果:$result');
     print('------------------');
   var status = response?.statusCode;
     switch (status) {
      case 200:
        return result;
      case 401:
        throw  NeedLogin();
      case 403:
       throw  NeedAuth(result.toString(), data: result);
      default:
        // 如果 error 不为空，则复用现有的 error
       throw error ?? HiNetError(status ?? -1, result.toString(), data: result);
    }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    print('i_net:url:${request.url()}');
    //使用Dio发送请求
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
    
  }

  void printLog(log) {
    print('hi_net:${log.toString()}');
  }
}
