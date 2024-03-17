
import 'dart:convert';

import 'package:blibli/http/request/base_request.dart';
//网络请求抽象类
abstract class HiNetAdapter{
  // ignore: non_constant_identifier_names
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}



//统一的网络返回格式
class HiNetResponse<T> {
  HiNetResponse({
    this.data,
    required this.request,
    this.statusCode,
    this.statusMessage,
    this.extra,
  });


  T? data;
  BaseRequest request;
  int? statusCode;
  String? statusMessage;
  late dynamic extra;
  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
