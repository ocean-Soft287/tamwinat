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



final getTmwenatProProvider = ChangeNotifierProvider((ref) => GetTamwenatProFromApi());
class GetTamwenatProFromApi extends ChangeNotifier{
  GetTamwenatProFromApi(){
    getTamwenatProProduct();
  }

  List<Map<String, dynamic>> TamwenatProList=[];
  void getTamwenatProProduct(){
    DioHelperOneSystem.getData(url:'api/DeliveringSubscriptions')
        .then((value){

      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

print(value.data);
      final decryptedText = decrypt(encryptedText, privateKey, publicKey);




      TamwenatProList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
print(TamwenatProList);
      notifyListeners();

    }).catchError((error){

      print('is Error == $error');


    });

  }
 late  num Amount ;

  int SelectIndex=-1;

  void changeSelect(int index){
    SelectIndex=index;
    Amount=TamwenatProList[index]['Value'];
    notifyListeners();
  }


  void createDeliverySubscription( {required num valueAmount,required num period,}){

    String encryptedData = encryptData(
        {
          "CustomerPhone" :UserPhone,
          "Value":valueAmount,
          "Period":period,
          "StartDate":DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()
        }, privateKey, publicKey);
    String jsonData = jsonEncode(encryptedData);
    DioHelperOneSystem.postData(url: 'api/DeliverySubscribers/Create', data:jsonData )
        .then((value){
print(value.data);
final encryptedText = value.data;
const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
const publicKey = 'e0c9de1b2de26fe2';

print(value.data);
final decryptedText = decrypt(encryptedText, privateKey, publicKey);
print(decryptedText);

notifyListeners();
    })

        .catchError((error) {

      print('This is Error In Tmwenat Pro ${error.toString()}');

    });
  }



}