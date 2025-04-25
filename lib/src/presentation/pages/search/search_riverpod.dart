
import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main/pickup/One System/DioOneSystem.dart';

final getDataSearchApiProvider = ChangeNotifierProvider((ref) => GetSearchFromApi());
class GetSearchFromApi extends ChangeNotifier{


  dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
    final keyObj = encrypt.Key.fromUtf8(privateKey); // 32 chars
    final ivObj = encrypt.IV.fromUtf8(publicKey); // 16 chars
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




  List<Map<String, dynamic>> searchList=[];

  void getSearch({required String search}){
    searchList=[];
    print('GAMAL   ${search}');
    DioHelperOneSystem.getData(url:'api/Product/SearchProducts?searchKey=${search}')
        .then((value){
      print('GAMALBARAKAT   ${search}');
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



      searchList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
      print(searchList.length);
      print(searchList[1]);

      notifyListeners();

    }).catchError((error){

      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');

    });

  }
}


final SearchBarCodeApiProvider = ChangeNotifierProvider((ref) => SearchBarcodeFromApi());
class SearchBarcodeFromApi extends ChangeNotifier{


  dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
    final keyObj = encrypt.Key.fromUtf8(privateKey); // 32 chars
    final ivObj = encrypt.IV.fromUtf8(publicKey); // 16 chars
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




  List<Map<String, dynamic>> searchBarCodeList=[];
  void getSearchBarCode({required String search}){
    searchBarCodeList.clear();
    DioHelperOneSystem.getData(url:'api/Product/SearchProductByBarcode?Barcode=${search}')
        .then((value){

      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');



      searchBarCodeList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
      print(searchBarCodeList.length);


      notifyListeners();

    }).catchError((error){

      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');

    });

  }
}