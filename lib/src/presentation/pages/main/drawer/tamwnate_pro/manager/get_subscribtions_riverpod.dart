import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../../../main.dart';
import '../../../../auth/login/one_system/login_riverpod.dart';
import '../../../pickup/One System/DioOneSystem.dart';
import '../../../pickup/One System/riverpodOneSystem/notifierOneSystem.dart';
dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
  final keyObj = encrypt.Key.fromUtf8(privateKey);
  final ivObj = encrypt.IV.fromUtf8(publicKey);
  final encrypter = encrypt.Encrypter(
      encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));

  try {
    final decrypted = encrypter.decrypt(
        encrypt.Encrypted.fromBase64(encryptedText), iv: ivObj);
    return decrypted;
  } catch (e) {
    print("Error decrypting data: $e");
    return 'Error....................';
  }
}



final getSubscriptionProvider = ChangeNotifierProvider((ref) => GetSubscriptionProviderApi());
class GetSubscriptionProviderApi extends ChangeNotifier{
  GetSubscriptionProviderApi(){
    getSubscription();
  }

  List<Map<String, dynamic>> subscriptionList=[];
  void getSubscription(){
    DioHelperOneSystem.getData(url:'api/DeliverySubscribers/GetSubscribers?CustomerPhone=$UserPhone')
        .then((value){

      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      print(value.data);
      final decryptedText = decrypt(encryptedText, privateKey, publicKey);




      subscriptionList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
      print(subscriptionList);
      notifyListeners();

    }).catchError((error){

      print('is Error == $error');


    });

  }



}