//Dio适配器

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:blibli/http/core/hi_error.dart';
import 'package:blibli/http/core/hi_net_adapter.dart';
import 'package:blibli/http/request/base_request.dart';
import 'package:blibli/util/log.dart';
import 'package:dio/dio.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.header);
   Dio dio = Dio();
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await dio.get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await dio
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await dio
            .delete(request.url(), data: request.params, options: options);
      }

    } on DioException catch (e) {
      error = e;
      response = e.response;
      if (response != null) {
        Log().error(response.data);
        Log().error(response.headers);
        Log().error(response.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        Log().error(e.requestOptions);
        Log().error(e.message);
      }
    }
    
    if (error != null) {
      throw HiNetError(response?.statusCode ?? -1, error.message,
          data: await buildRes(response, request));
    }
    return buildRes(response, request);
  }

  Future<HiNetResponse<T>> buildRes<T>(
      Response? response, BaseRequest request) {
    return Future.value(
      HiNetResponse(
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response,
      ),
    );
  }
}
