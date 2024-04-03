
import 'dart:convert';

import '../request/hi_base_request.dart';
//网络请求抽象类
abstract class HiNetAdapter{
  Future<HiNetResponse<T>> send<T>(HiBaseRequest request);
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
  HiBaseRequest request;
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
