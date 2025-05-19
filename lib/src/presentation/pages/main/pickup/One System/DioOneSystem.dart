import 'package:dio/dio.dart';

//    baseUrl: 'http://37.34.242.173:9292/TheOneAPI/', test" 'http://15.235.51.177/TheOneAPI/'
class DioHelperOneSystem {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl:
      // 'http://15.235.51.177/TheOneAPIeAPI/',
       'http://37.34.242.173:9292/TheOneApiTest/',
      // 'http://37.34.242.173:9292/TheOneAPI/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({required String url}) async {
    dio.options.headers = {
      'Authorization':
          'Basic ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ=='
    };

    return await dio.get(url);
  }

  static Future<Response> updateData(
      {required String url, required dynamic data}) async {
    dio.options.headers = {
      'Authorization':
          'Basic ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ==',
      'Content-Type': 'application/json',
    };

    return await dio.put(url, data: data);
  }

  static Future<Response> postData(
      {required String url, required dynamic data,  Options? options }) async {

    dio.options.headers = {
      'Authorization':
          'Basic ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ=='
    };

    return dio.post(url, data: data);
  }

  static Future<Response> delelet({required String url}) async {
    dio.options.headers = {
      'Authorization':
          'Basic ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ==',
      'Content-Type': 'application/json',
    };
    return dio.delete(url);
  }

// static Future<Response>putData({required String url,Map<String,dynamic> ?data,String?token })async
// {
//
//   return   dio.put(url,data: data);
// }
}
