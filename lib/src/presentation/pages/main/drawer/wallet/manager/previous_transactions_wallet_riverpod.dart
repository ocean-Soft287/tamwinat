
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:intl/intl.dart';

import '../../../../../../../main.dart';
import '../../../../auth/login/one_system/login_riverpod.dart';
import '../../../pickup/One System/DioOneSystem.dart';
import '../../../pickup/One System/riverpodOneSystem/notifierOneSystem.dart';
import '../view/wallet_screen.dart';
final getPreviousTransactionWalletProvider = ChangeNotifierProvider((ref) => GetPreviousTransactionWalletFromApi());
class GetPreviousTransactionWalletFromApi extends ChangeNotifier{

  GetPreviousTransactionWalletFromApi(){
    getPreviousTransaction(startDate: 2024-07-01,endDate: 2024-07-28);
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


  List<Map<String,dynamic>> previousTransactionList=[];
  DateTime now = DateTime.now();
  void getPreviousTransaction({required dynamic startDate,required dynamic endDate}){


    print(startDate.runtimeType);
    print(endDate.runtimeType);
    print(UserPhone);

    print(UserPhone.runtimeType);

    DioHelperOneSystem.getData(url:'api/POSLedger/GetCustomerBalance?CustomerPhone=$UserPhone&StartDate=2023-02-01&EndDate=${DateFormat('yyyy-MM-dd').format(DateTime.now())}')
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



      previousTransactionList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();


      print(previousTransactionList);

      notifyListeners();

    }).catchError((error){

      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');

    });

  }
 dynamic startDate;
  dynamic endDate;


  Future<void> getStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {

      startDate = picked;

      startDate='${startDate!.year}-${startDate!.month}-${startDate!.day}' ;
        notifyListeners();
    }
  }
  Future<void> getEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {

      endDate = picked;

      endDate='${endDate!.year}-${endDate!.month}-${endDate!.day}' ;

      notifyListeners();
    }
  }


}