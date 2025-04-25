import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../DioOneSystem.dart';
import 'ProviderOneSystem.dart';
dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
  final keyObj = encrypt.Key.fromUtf8(privateKey); // 32 chars
  final ivObj = encrypt.IV.fromUtf8(publicKey); // 16 chars
  final encrypter = encrypt.Encrypter(encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));

  try {
    final decrypted = encrypter.decrypt(encrypt.Encrypted.fromBase64(encryptedText), iv: ivObj);
    return decrypted;
  } catch (e) {
    print("Error decrypting data: $e");
    return 'Error....................';
  }
}
void getCatgoryAll( ref) {
  DioHelperOneSystem.getData(url:'api/Product/GetAllProducts?pageNumber=1&pageSize=20')
      .then((value) {
    final encryptedText = value.data;
    final privateKey = 'c104780a25b4f80c037445dd1f6947e1'; // استبدل بالمفتاح الخاص بك
    final publicKey = 'e0c9de1b2de26fe2'; // استبدل بالـ IV الخاص بك

    final decryptedText = decrypt(encryptedText, privateKey, publicKey);

    List<Map<String, dynamic>> dataCategoryAllList =
    (json.decode(decryptedText) as List<dynamic>)
        .map((item) => item as Map<String, dynamic>)
        .toList();

    ref.read(categoryDataProvider.notifier).setData(dataCategoryAllList);

    print(dataCategoryAllList[0]["ColorArName"]);
    print(dataCategoryAllList[0]["BarCode"]);
    print('Decrypted Text Gamal 101020200000000: $decryptedText');
  }).catchError((error) {
    print('is Error == $error');
  });
}


//function encryptData
String encryptData(Map<String,dynamic> data, String privateKey, String publicKey) {
  final key = encrypt.Key.fromUtf8(privateKey); // 32 chars
  final iv = encrypt.IV.fromUtf8(publicKey); // 16 chars
  final encrypter = encrypt.Encrypter(
    encrypt.AES(key, mode: encrypt.AESMode.cbc),
  );
   try{
     String jsonString = json.encode(data);
     final encrypted = encrypter.encrypt(jsonString, iv: iv);
     final encryptedText = encrypted.base64;
     return encryptedText;
   }
   catch(e){
     print("Error encryptData : $e");
     return 'Error....................';
   }

}

void orderItem({
  required String OrderDate,required String CustomerPhone ,required String CustomerName,
  required String CustomerAddress,required num TotalValue,
  required num Additions,required num Discount,required num FinalValue,
  required num PayID,required num OnlineStoreId,
}){
  final privateKey = 'c104780a25b4f80c037445dd1f6947e1'; // استبدل بالمفتاح الخاص بك
  final publicKey = 'e0c9de1b2de26fe2';
  String encryptedData = encryptData({
    "OrderDate":OrderDate,
    "CustomerPhone":CustomerPhone,
    "CustomerName":CustomerName,
    "CustomerAddress":CustomerAddress,
    "TotalValue":TotalValue,
    "Additions":Additions,
    "Discount":Discount,
    "FinalValue":FinalValue,
    "PayID":PayID,
    "OnlineStoreId":OnlineStoreId,
    "_OrderItems":
    [{"ItemID":28,"Quantity":1,"Price":70},]
  }, privateKey, publicKey);
  print("Encrypted Data: $encryptedData");

  print('Gamal.........................');
  DioHelperOneSystem.postData(url: 'api/Order', data: encryptedData)
      .then((value) {
       print('Success post Order');

  }).catchError((error){
    print('Error post Order');
    print(error.toString());
  });

}



















//
// final getDataFuture=ChangeNotifierProvider<GetDataFromApi>((ref)=>GetDataFromApi());

final getDataFromApiProvider = ChangeNotifierProvider((ref) => GetDataFromApi());
class GetDataFromApi extends ChangeNotifier{
  GetDataFromApi(){
    getCategoryAll10();
  }
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

  List<Map<String, dynamic>> dataCategoryAllList=[];
  void getCategoryAll10(){

    DioHelperOneSystem.getData(url:'api/Product/GetAllProducts?pageNumber=1&pageSize=80')
        .then((value){
      print('11111111111111111111111111111111111111111111111111111');
      print('Success');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);




      dataCategoryAllList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();

      print(dataCategoryAllList[0]["ColorArName"]);
      print(dataCategoryAllList[0]["BarCode"]);
      print(dataCategoryAllList[0]);
      print('00000000000000');
      print(dataCategoryAllList);
      print('11111111111111111111');
      print(dataCategoryAllList[2]);
print(dataCategoryAllList.length);
      notifyListeners();

    }).catchError((error){

      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');

    });

  }
}













