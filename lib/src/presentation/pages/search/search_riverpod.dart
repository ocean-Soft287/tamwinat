
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
      return 'Error....................';
    }
  }




  List<Map<String, dynamic>> searchList=[];

  void getSearch({required String search}){
    searchList=[];
    DioHelperOneSystem.getData(url:'api/Product/SearchProducts?searchKey=${search}')
        .then((value){
  final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);




      searchList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();

      notifyListeners();

    }).catchError((error){


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
      return 'Error....................';
    }
  }




  List<Map<String, dynamic>> searchBarCodeList=[];
  void getSearchBarCode({required String search}){
    searchBarCodeList.clear();
    DioHelperOneSystem.getData(url:'api/Product/SearchProductByBarcode?Barcode=${search}')
        .then((value){

       final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);




      searchBarCodeList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();


      notifyListeners();

    }).catchError((error){


    });

  }
}