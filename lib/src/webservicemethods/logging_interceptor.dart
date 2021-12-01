import 'dart:developer';

import 'package:assignment/src/util/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    handler.next(options);
    // return super.onRequest(options,handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    appLog('-----------New Api Call Start--------------');
    appLog('-------------REQUEST-----------------');
    appLog('<-Method->   ${response.requestOptions.method}');
    appLog('<-BaseUrl->  ${response.requestOptions.baseUrl}');
    appLog('<-Params->   ${response.requestOptions.queryParameters}');

    appLog('<-Path->     ${response.requestOptions.path}');
    appLog('<-Headers->  ${response.requestOptions.headers}');
    appLog('<-Req Body->     ${response.requestOptions.data}');
    appLog('-------------RESPONSE----------------');
    appLog('<-Res Body-> ${response.data.toString()}');
    appLog('-----------New Api Call End--------------');


    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {

    appLog('-----------New Api Error--------------');
    appLog('<-Method-> ${err.requestOptions.method}');
    appLog('<-BaseUrl-> ${err.requestOptions.baseUrl}');
    appLog('<-Params-> ${err.requestOptions.queryParameters}');
    appLog('<-Path-> ${err.requestOptions.path}');
    appLog('<-Headers-> ${err.requestOptions.headers}');

    handler.next(err);

  }
}
