import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sundaymart/src/presentation/pages/main/pickup/One%20System/DioOneSystem.dart';


import '../notification_model/notification_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  Future<void> getAllNotification() async {
    emit(NotificationLoading());
    try {
      Response value = await DioHelperOneSystem.getData(url:"api/Notifications");
      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';
      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      List data = json.decode(decryptedText);
      List<NotificationsModel> allNotification = [];
      for (int i = 0; i < data.length; i++) {
        allNotification.add(NotificationsModel.fromJson(data: data[i]));
      }
      emit(NotificationSuccess(allNotification: allNotification));

    } on Exception catch (_) {


    }
  }

  dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
    final keyObj = encrypt.Key.fromUtf8(privateKey);
    final ivObj = encrypt.IV.fromUtf8(publicKey);
    final encrypter =
        encrypt.Encrypter(encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));

    try {
      final decrypted = encrypter
          .decrypt(encrypt.Encrypted.fromBase64(encryptedText), iv: ivObj);
      return decrypted;
    } catch (e) {
      print("Error decrypting data: $e");
      return 'Error....................';
    }
  }



}

// class DioHelperOneSystem10{
//   static late Dio dio;
//   static init() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: 'http://37.34.242.173:9292/TheOneAPI/',
//         receiveDataWhenStatusError: true,
//       ),
//     );
//   }
//
//   static Future<Response> getData() async {
//     dio.options.headers = {
//       'Authorization':
//           'Basic ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ=='
//     };
//
//     return await dio.get("api/Notifications";
// //   })
// }