import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../main.dart';
import '../../../pickup/One System/DioOneSystem.dart';





final getDataMyPreviousRequetsApiProvider = ChangeNotifierProvider((ref) => GetMyPreviousRequetsFromApi());
class GetMyPreviousRequetsFromApi extends ChangeNotifier{


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


Stream<List<Map<String, dynamic>>> getMyPreviousRequetsPhoneStreamBuilder() async* {

 while (true) {

   yield  await getMyPreviousRequetsPhoneStream( );
  await Future.delayed(const Duration(seconds: 30));

 }
  
}

  List<Map<String, dynamic>> myPreviousRequetsProductList=[];

  void getMyPreviousRequetsProduct({required dynamic ItemID}){
    DioHelperOneSystem.getData(url:'api/Order/GetOrderProducts/${ItemID}?CustomerPhone=${UserPhone}')
        .then((value){

      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      myPreviousRequetsProductList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
      print(myPreviousRequetsProductList.length);
      print('myPreviousRequetsProductList    ${myPreviousRequetsProductList[0]}');
      print('myPreviousRequetsProductList    ${myPreviousRequetsProductList[1]}');
      print('myPreviousRequetsProductList    ${myPreviousRequetsProductList[2]}');
      notifyListeners();

    }).catchError((error){

      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');

    });

  }


  List<Map<String, dynamic>> myPreviousRequetsPhoneList=[];
  void getMyPreviousRequetsPhone(){
    DioHelperOneSystem.getData(url:'api/Order/GetByCustomerPhone/${UserPhone}')
        .then((value){


      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);




      myPreviousRequetsPhoneList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();

print('***************************************');
print(myPreviousRequetsPhoneList.length);
print('-----------------------------------------');
print(myPreviousRequetsPhoneList[0]["OrderNo"]);
print(myPreviousRequetsPhoneList[1]["OrderNo"]);
print('****************************************');

      notifyListeners();

    }).catchError((error){

      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');

    });

  }

  Future<List<Map<String, dynamic>> > getMyPreviousRequetsPhoneStream()async{
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

         final encryptedText = await   DioHelperOneSystem.getData(url:'api/Order/GetByCustomerPhone/${UserPhone}');
    
       
      final decryptedText = decrypt(encryptedText.data, privateKey, publicKey);
  
    return
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
  
  }


}

// **********************************************************************************









