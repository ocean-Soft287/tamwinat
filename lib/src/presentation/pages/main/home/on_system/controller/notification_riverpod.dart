import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import '../../../pickup/One System/DioOneSystem.dart';
final getNotificationRiverpod =
ChangeNotifierProvider((ref) => GetNotificationFromApi());

class GetNotificationFromApi extends ChangeNotifier {
  GetNotificationFromApi() {
    getNotificatio();
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

  List<Map<String, dynamic>> notificationList = [];
  void getNotificatio() {
    DioHelperOneSystem.getData(url: 'api/Notifications').then((value) {
      print('Success');
      print('مشفرره');
      print(value.data);
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      notificationList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(notificationList);



      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}