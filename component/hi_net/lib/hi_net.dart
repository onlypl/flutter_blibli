library hi_net;

import 'package:logger/web.dart';

import 'core/dio_adapter.dart';
import 'core/hi_error.dart';
import 'core/hi_net_adapter.dart';
import 'request/hi_base_request.dart';

/// 1.支持网络库插拔设计，且不干扰业务层
/// 2.基于配置请求请求，简洁易用
/// 3.Adapter设计，扩展性强
/// 4.统一异常和返回处理
class HiNet {
  HiNet._();
  static HiNet? _instance;
  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance!;
  }

  Future fire(HiBaseRequest request) async {
    HiNetResponse? response;
    var error;

    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
    } catch (e) {
       Logger().e('错误:${e.toString()}');
      error = e;
    }

    var result = response?.data;
    Logger().d('请求结果:$result');
     Logger().d('请求到结果------------------');
   var status = response?.statusCode;
     switch (status) {
      case 200:
        return result;
      case 401:
        throw  NeedLogin();
      case 403:
      //  showWarnToast(response?.statusMessage ??'未知异常');
       throw  NeedAuth(response?.statusMessage ??'未知异常', data: result);
      default:
       throw  error ?? HiNetError(status ?? -1, result.toString(), data: result);
    }
  }

  Future<dynamic> send<T>(HiBaseRequest request) async {
    Logger().d('i_net:url:${request.url()}');
    //使用Dio发送请求
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
    
  }
}
