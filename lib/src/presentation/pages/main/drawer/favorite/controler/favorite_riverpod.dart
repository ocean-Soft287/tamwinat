import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../main.dart';
import '../../../pickup/One System/DioOneSystem.dart';
import '../../../pickup/One System/riverpodOneSystem/notifierOneSystem.dart';


final getDataFavoriteApiProvider =
    ChangeNotifierProvider((ref) => GetFavoriteAllFromApi());

class GetFavoriteAllFromApi extends ChangeNotifier {
  GetFavoriteAllFromApi() {
    getFavorite();
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

  List<Map<String, dynamic>> favoriteList = [];
  void getFavorite() {
    DioHelperOneSystem.getData(
            url: 'api/Customer/GetCustomerProducts?CustomerPhone=${UserPhone}')
        .then((value) {
      print('getFavorite');
      print('getFavorite');
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      favoriteList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(favoriteList.length);
      print(favoriteList[1]);

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}

//----------------------------------------Add In Favorite------------------
final addItemFavoriteProvider = ChangeNotifierProvider<AddItemFavorite>((ref) {
  return AddItemFavorite();
});

class AddItemFavorite extends ChangeNotifier {
  String encryptData(
      Map<String, dynamic> data, String privateKey, String publicKey) {
    final key = encrypt.Key.fromUtf8(privateKey); // 32 chars
    final iv = encrypt.IV.fromUtf8(publicKey); // 16 chars
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    try {
      String jsonString = json.encode(data);
      final encrypted = encrypter.encrypt(jsonString, iv: iv);
      final encryptedText = encrypted.base64;
      return encryptedText;
    } catch (e) {
      print("Error encryptData : $e");
      return 'Error....................';
    }
  }

  void AddItemFavoritePost(
      {required String CustomerPhone, required String ProductID}) {
    final privateKey =
        'c104780a25b4f80c037445dd1f6947e1'; // استبدل بالمفتاح الخاص بك
    final publicKey = 'e0c9de1b2de26fe2';
    String encryptedData = encryptData(
        {"CustomerPhone": CustomerPhone, "ProductID": ProductID},
        privateKey,
        publicKey);
    print("Encrypted Data: $encryptedData");
    String jsonData = jsonEncode(encryptedData);
    print('Gamal............5/2/2024.............');
    DioHelperOneSystem.postData(
            url: 'api/Customer/AddCustomerProduct', data: jsonData)
        .then((value) {
      print(value.data);

      print('Success post Add in Favorite    $ProductID ');
      // Succes=value.data;
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      notifyListeners();
    }).catchError((error) {
      print('Error Add In favorite');
      print(error.toString());
    });
  }
}

//-------------------------------------------------delete In Favorite-------------------------------------------

final deleteItemFavoriteProvider =
    ChangeNotifierProvider<DeleteItemFavorite>((ref) {
  return DeleteItemFavorite();
});

class DeleteItemFavorite extends ChangeNotifier {
  String encryptData(
      Map<String, dynamic> data, String privateKey, String publicKey) {
    final key = encrypt.Key.fromUtf8(privateKey); // 32 chars
    final iv = encrypt.IV.fromUtf8(publicKey); // 16 chars
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    try {
      String jsonString = json.encode(data);
      final encrypted = encrypter.encrypt(jsonString, iv: iv);
      final encryptedText = encrypted.base64;
      return encryptedText;
    } catch (e) {
      print("Error encryptData : $e");
      return 'Error....................';
    }
  }

  void DeleteItemFavoritePost({required dynamic ProductId}) {

    DioHelperOneSystem.delelet(
            url:
                'api/Customer/DeleteCustomerProduct?CustomerPhone=${UserPhone}&ProductID=${ProductId}')
        .then((value) {
      print(value.data);

      print('Success  Delete Item in Favorite    ');

      notifyListeners();
    }).catchError((error) {
      print('Error Delete Item In favorite');
      print(error.toString());
    });
  }
}

//---------------------------------------Plottics Is Privacy-----------------------

final getPoliticsIsPrivacyApiProvider =
    ChangeNotifierProvider((ref) => GetPoliticsIsPrivacyAllFromApi());

class GetPoliticsIsPrivacyAllFromApi extends ChangeNotifier {
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

  List<Map<String, dynamic>> politicsIsPrivacyList = [];
  void getPoliticsIsPrivacyImage() {
    DioHelperOneSystem.getData(url: 'api/Privacy').then((value) {
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('******');

      politicsIsPrivacyList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}


//------------------------------------------About Us---------------------------
final getAboutUsApiProvider =
    ChangeNotifierProvider((ref) => GetAboutUsFromApi());

class GetAboutUsFromApi extends ChangeNotifier {
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

  List<Map<String, dynamic>> aboutUsFromApiList = [];
  void getAboutUsImage() {
    DioHelperOneSystem.getData(url: 'api/AboutUs').then((value) {
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      aboutUsFromApiList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(aboutUsFromApiList.length);

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}

//---------------------------------------Delete Account--------------

final deleteAccountProvider = ChangeNotifierProvider<DeleteAccount>((ref) {
  return DeleteAccount();
});

class DeleteAccount extends ChangeNotifier {
  deleteAccountProvider() {
    deleteAccount();
  }

  String encryptData(
      Map<String, dynamic> data, String privateKey, String publicKey) {
    final key = encrypt.Key.fromUtf8(privateKey); // 32 chars
    final iv = encrypt.IV.fromUtf8(publicKey); // 16 chars
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    try {
      String jsonString = json.encode(data);
      final encrypted = encrypter.encrypt(jsonString, iv: iv);
      final encryptedText = encrypted.base64;
      return encryptedText;
    } catch (e) {
      print("Error encryptData : $e");
      return 'Error....................';
    }
  }

  void deleteAccount() {

    DioHelperOneSystem.delelet(
            url: 'api/Customer/DeleteCustomer?CustomerPhone=${UserPhone}')
        .then((value) {
      print(value.data);

      print('Success  Delete Account    ');

      notifyListeners();
    }).catchError((error) {
      print('Error Delete Account ');
      print(error.toString());
    });
  }
}
