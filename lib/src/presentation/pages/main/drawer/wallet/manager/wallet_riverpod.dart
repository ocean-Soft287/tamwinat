
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import '../../../../../../../main.dart';
import '../../../../auth/login/one_system/login_riverpod.dart';
import '../../../pickup/One System/DioOneSystem.dart';
import '../../../pickup/One System/riverpodOneSystem/notifierOneSystem.dart';
import '../view/wallet_screen.dart';
final getWalletApiProvider = ChangeNotifierProvider((ref) => GetWalletApiFromApi());
class GetWalletApiFromApi extends ChangeNotifier{

  GetWalletApiFromApi(){
    getWalletAmount();
  }
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


 List<Map<String,dynamic>> amountValueList=[];

  void getWalletAmount(){

    DioHelperOneSystem.getData(url:'api/DiscountCards/GetDiscountCardByPhone?CustomerPhone=$UserPhone')
        .then((value){


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



      amountValueList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();

      print('amountValueList.length      ${amountValueList.length}');
      print(amountValueList[0]);

      notifyListeners();

    }).catchError((error){

      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');

    });

  }


  void depositValue( {required dynamic deposit_value,required  context}){

    String encryptedData = encryptData(
        {
          "VoucherValue":deposit_value,
          "CustomerPhone":UserPhone

        }, privateKey, publicKey);
    String jsonData = jsonEncode(encryptedData);
    DioHelperOneSystem.postData(url: 'api/Voucher/CreateVoucher', data:jsonData )
        .then((value){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DepositSuccessScreen(),
        ),
      );
          notifyListeners();
    })

        .catchError((error) {

    });
  }



}