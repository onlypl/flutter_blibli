// ignore_for_file: constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print
import 'package:hi_base/log.dart';
import 'package:logger/web.dart';

enum HttpMethod { GET, POST, DELETE }
//基础请求

abstract class HiBaseRequest {
  var pathParams; //参数

  var userHtpps = true; //默认请求https
  String autority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();
  String path(); //路径
  String url() {
    Uri uri;
    var pathStr = path();
    //拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        //结尾是否包含/
        pathStr = '${path()}$pathParams';
      } else {
        pathStr = '${path()}/$pathParams';
      }
    }
    //http和https切换
    if (userHtpps) {
      uri = Uri.https(autority(), pathStr, params);
    } else {
      uri = Uri.http(autority(), pathStr, params);
    }
    Log().debug('url地址:${uri.toString()}');
    return uri.toString();
  }

  bool needLogin();
  Map<String, String> params = {};
  //添加参数
  HiBaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = {};
  //添加参数
  HiBaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
