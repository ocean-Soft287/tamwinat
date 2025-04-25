import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../main.dart';
import '../../../../auth/login/one_system/login_riverpod.dart';
import '../../../pickup/One System/DioOneSystem.dart';
import '../../../pickup/One System/riverpodOneSystem/notifierOneSystem.dart';




final walletPointsProvider =
ChangeNotifierProvider<WalletPoints>((ref) {
  return WalletPoints();
});

class  WalletPoints extends ChangeNotifier {
  WalletPoints(){
    getWalletPoints();
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

  int indexSelected=1;
  void changeSelectedIndex({required int index}){
    indexSelected=index;
    notifyListeners();

  }
  List<Map<String, dynamic>> walletPointsList=[];
  void getWalletPoints(){
    DioHelperOneSystem.getData(url:'api/DiscountCards/GetDiscountCardByPhone?CustomerPhone=$UserPhone')
        .then((value){

      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';


      final decryptedText = decrypt(encryptedText, privateKey, publicKey);




      walletPointsList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
print(walletPointsList);
      notifyListeners();

    }).catchError((error){

      print('is Error == $error');


    });

  }

  final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
  final publicKey = 'e0c9de1b2de26fe2';
  void updateCustomerWalletValue({required dynamic context}){


    String encryptedData = encryptData({
      "CustomerPhone":UserPhone,
      "PointsValue" :'${walletPointsList[0]['PointsValue']}'
    }, privateKey, publicKey);
    print("Encrypted Data: $encryptedData");
    String jsonData = jsonEncode(encryptedData);
    DioHelperOneSystem.updateData(url:'api/DiscountCards/UpdateCustomerCard', data: jsonData)


        .then((value){
      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';


      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

print(decryptedText);
      getWalletPoints();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('تم تحويل النقاط بنجاح'),
        ),
      );

      notifyListeners();
    })
        .catchError((error){});

  }

}