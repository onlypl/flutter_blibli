// ignore_for_file: unused_element, avoid_print, constant_identifier_names

import 'package:blibli/db/hi_cache.dart';
import 'package:hi_base/log.dart';
import 'package:hi_net/hi_net.dart';
import 'package:blibli/http/request/login_request.dart';
import 'package:blibli/http/request/registration_request.dart';

import '../request/base_request.dart';
class LoginDao {
  static const BOAROING_PASS = 'boarding-pass';
  static login(String userName, String password) {
    return _send(userName, password);
  }

  static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String userName, String password, {imoocId, orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
           request = RegistrationRequest();
            request.add("imoocId", imoocId).add("orderId", orderId);
    } else {
       request = LoginRequest();
    }
    request.add("userName", userName).add("password", password);

    var result = await HiNet.getInstance().fire(request);
    //  Log().info(result);
    //  Log().info("1-------------------");
    
    if(result['code'] == 0 &&result['data']!=null){
        //保存登录令牌
        HiCache.getInstance().setString(BOAROING_PASS, result['data']);
        Log().info("保存令牌");
    
    }
   // Log().info("2-------------------");
    return result;
  }
  static getBoardingPass(){
    return HiCache.getInstance().get(BOAROING_PASS);
  }
}
