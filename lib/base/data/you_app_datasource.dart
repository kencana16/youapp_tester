import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class YouAppDatasource {
  final Dio _dio;

  Dio get dio => _dio;

  YouAppDatasource({
    /// for testing purpose
    Dio? dio,
  }) : _dio =
            dio ?? Dio(BaseOptions(baseUrl: 'https://techtest.youapp.ai/api')) {
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          debugPrint(object.toString(), wrapWidth: 9999);
        },
      ));
    }
  }
}
