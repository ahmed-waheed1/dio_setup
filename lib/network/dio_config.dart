import 'package:dio/dio.dart';
import 'package:dio_setup/network/constant.dart';

class DioConfig {
  DioConfig._();
  static Dio? _dio;
  static Dio get dio {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeOut,
        receiveTimeout: receiveTimeOut,
      ),
    );
    _dio!.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ));
    return _dio!;
  }
}
