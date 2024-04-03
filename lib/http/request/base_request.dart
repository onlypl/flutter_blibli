// ignore_for_file: constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'package:blibli/http/dao/login_dao.dart';
import 'package:hi_net/request/hi_base_request.dart';
import '../../util/hi_constants.dart';

abstract class BaseRequest extends HiBaseRequest {
  @override
  String url() {
    if (needLogin()) {
      //给需要的接口携带登录令牌
      addHeader(LoginDao.BOAROING_PASS, LoginDao.getBoardingPass());
    }
    return super.url();
  }

  @override
  // ignore: overridden_fields
  Map<String, dynamic> header = {
    'course-flag': HiConstants.courseFlagV,
    'auth-token': HiConstants.authTokenV,
  };
}
