import 'package:dio/dio.dart';

import '../constants/constants.dart';
import 'token_interceptor.dart';

class HttpService {

  Dio client({bool requireAuth = false}) => Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
      sendTimeout: Duration(seconds: 60),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json'
      },
    ),
  )
    ..interceptors.add(TokenInterceptor(requireAuth: requireAuth))
    ..interceptors.add(LogInterceptor());
}
