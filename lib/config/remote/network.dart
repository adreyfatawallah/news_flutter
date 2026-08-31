import 'package:dio/dio.dart';
import 'package:news/features/news/core/api.dart';

Dio setupDio() {
  final options = BaseOptions(
    baseUrl: Api.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  final dio = Dio(options);
  dio.interceptors.add(
    LogInterceptor(
      requestUrl: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
    ),
  );

  return dio;
}
