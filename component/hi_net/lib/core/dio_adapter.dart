//Dio适配器

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import '../request/hi_base_request.dart';
import 'hi_error.dart';
import 'hi_net_adapter.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(HiBaseRequest request) async {
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
        Logger().d(response.data);
        Logger().d(response.headers);
        Logger().d(response.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        Logger().d(e.requestOptions);
        Logger().d(e.message);
      }
    }
    
    if (error != null) {
      throw HiNetError(response?.statusCode ?? -1, error.message,
          data: await buildRes(response, request));
    }
    return buildRes(response, request);
  }

  Future<HiNetResponse<T>> buildRes<T>(
      Response? response, HiBaseRequest request) {
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
