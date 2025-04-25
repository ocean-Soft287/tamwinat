import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../main.dart';
import '../../../pickup/One System/DioOneSystem.dart';

final getDataStateProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  return GetMyPreviousRequestStateFromApi().previousRequestStateStream;
});

class GetMyPreviousRequestStateFromApi {
  Stream<List<Map<String, dynamic>>> get previousRequestStateStream async* {
    while (true) {
      yield await getPreviousRequestState();
      await Future.delayed(const Duration(seconds: 30));
    }
  }

  Future<List<Map<String, dynamic>>> getPreviousRequestState() async {
    try {
      final response = await DioHelperOneSystem.getData(
        url: 'api/Order/GetCurrentOrdersByCustomerPhone/$UserPhone',
      );
print('111111111111111111111111111111111111111');
      final encryptedText = response.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';
print(encryptedText);
      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
print('-----------------------');
      print(decryptedText);
      print('-----------------------');
      return (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();

    } catch (e) {
      print("Error decrypting data: $e");
      return [];
    }
  }

  dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
    final keyObj = encrypt.Key.fromUtf8(privateKey);
    final ivObj = encrypt.IV.fromUtf8(publicKey);
    final encrypter = encrypt.Encrypter(encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));

    try {
      final decrypted = encrypter.decrypt(
          encrypt.Encrypted.fromBase64(encryptedText), iv: ivObj);
      return decrypted;
    } catch (e) {
      print("Error decrypting data: $e");
      return 'Error....................';
    }
  }
}

