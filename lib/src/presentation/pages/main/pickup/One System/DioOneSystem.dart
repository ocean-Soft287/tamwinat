import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Base URLs
const String testApiUrl = 'http://37.34.242.173:9292/TheOneAPITest/';//'http://15.235.51.177/TheOneAPITest/';
const String liveApiUrl = 'http://37.34.242.173:9292/TheOneApi/';

class DioHelperOneSystem {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: testApiUrl, // Change to testApiUrl if needed
      receiveDataWhenStatusError: true,
    ));

    // Add PrettyDioLogger interceptor
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      request: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  static Future<Response> getData({required String url}) async {
    dio.options.headers = {
      'Authorization':
          'Basic ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ=='
    };

    return await dio.get(url);
  }

  static Future<Response> updateData({
    required String url,
    required dynamic data,
  }) async {
    dio.options.headers = {
      'Authorization':
          'Basic ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ==',
      'Content-Type': 'application/json',
    };

    return await dio.put(url, data: data);
  }

  static Future<Response> postData({
    required String url,
    required dynamic data,
    Options? options,
  }) async {
    dio.options.headers = {
      'Authorization':
          'Basic ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ=='
    };

    return await dio.post(url, data: data, options: options);
  }

  static Future<Response> delelet({required String url}) async {
    dio.options.headers = {
      'Authorization':
          'Basic ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ==',
      'Content-Type': 'application/json',
    };
    return await dio.delete(url);
  }
}