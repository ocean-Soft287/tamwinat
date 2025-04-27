import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';

import '../../../../../../../../riverpod/gh.dart';

import '../../../../../../pages.dart';
import '../../../../../drawer/MyPreviousRequests/view/my_previous_requets_screen.dart';
import '../../../../../pickup/One System/DioOneSystem.dart';
//-----------------------------------------List Time Delivery--------------------------------
final getDataTimeDeliveryProvider =
ChangeNotifierProvider((ref) => GetDataTimeDelivery());
final getDataTimeDeliverynowProvider =
ChangeNotifierProvider((ref) => GetDeliveryTimenow());
class GetDataTimeDelivery extends ChangeNotifier {
  GetDataTimeDelivery() {
    getDataTimeDelivery();
  }

  dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
    final keyObj = encrypt.Key.fromUtf8(privateKey); // 32 chars
    final ivObj = encrypt.IV.fromUtf8(publicKey); // 16 chars
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

  List dataTimeDeliveryList = [];

  void getDataTimeDelivery() {
    DioHelperOneSystem.getData(url: 'api/DeliveringTimes').then((value) {
      print('1111111111111111111111111111111111111111111111');
      print('Success List Address');
      print(value.data);
      print('11111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      dataTimeDeliveryList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(dataTimeDeliveryList);

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}

//-----------------------------------------List Time Delivery Tomorow-------------------
final getDataTimeDeliveryTomorowProvider =
ChangeNotifierProvider((ref) => GetDataTimeDeliveryTomorow());

class GetDataTimeDeliveryTomorow extends ChangeNotifier {
  GetDataTimeDeliveryTomorow() {
    getDataTimeDeliveryTomorow();
  }

  dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
    final keyObj = encrypt.Key.fromUtf8(privateKey); // 32 chars
    final ivObj = encrypt.IV.fromUtf8(publicKey); // 16 chars
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

  List dataTimeDeliveryTomorowList = [];

  void getDataTimeDeliveryTomorow() {
    DioHelperOneSystem.getData(
        url: 'api/DeliveringTimes/TomorowDeliveringTimes')
        .then((value) {
      print('1111111111111111111111111111111111111111111111');
      print('Success List Address');
      print(value.data);
      print('11111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      dataTimeDeliveryTomorowList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
      print(dataTimeDeliveryTomorowList);

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}
class GetDeliveryTimenow extends ChangeNotifier {
  GetDeliveryTimenow() {
    getDataTimeDeliverynow();
  }

  dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
    final keyObj = encrypt.Key.fromUtf8(privateKey); // 32 chars
    final ivObj = encrypt.IV.fromUtf8(publicKey); // 16 chars
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

  List dataTimeDeliverynowList = [];
  bool isNowInDeliveryTime = false;

  void getDataTimeDeliverynow() {
    DioHelperOneSystem.getData(url: 'api/DeliveringTimes/NowDeliveringTimes')
        .then((value) {
      print('1111111111111111111111111111111111111111111111');
      print('Success List Address');
      print(value.data);
      print('11111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      dataTimeDeliverynowList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(dataTimeDeliverynowList);


      checkIfNowInDeliveryTime(); // هنا نعمل التشيك بعد ما نجيب الداتا
      print('0000سسس000000سسس00000000000000000000000000000000000000000000');

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }

  void checkIfNowInDeliveryTime() {
    isNowInDeliveryTime = false;

    if (dataTimeDeliverynowList.isEmpty) return;

    final now = DateTime.now();

    for (var item in dataTimeDeliverynowList) {
      final startTime = DateTime.parse(item['NowStartTime']);
      final endTime = DateTime.parse(item['NowEndTime']);
print(isNowInDeliveryTime);
      if (now.isAfter(startTime) && now.isBefore(endTime)) {
        isNowInDeliveryTime = true;
        print(isNowInDeliveryTime);
        return ;
      }
      else{
        print("isNowInDeliveryTime$isNowInDeliveryTime");
      }
    }
  }
}


