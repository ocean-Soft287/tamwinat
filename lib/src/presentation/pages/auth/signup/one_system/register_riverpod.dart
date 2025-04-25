import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/auth/login/one_system/CashHelper.dart';

import '../../../../../../main.dart';
import '../../../main/main_page.dart';
import '../../../main/pickup/One System/DioOneSystem.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import '../../../main/pickup/One System/riverpodOneSystem/notifierOneSystem.dart';
import '../../login/one_system/login_screen.dart';

final registerProvider = ChangeNotifierProvider<RegisterFun>((ref) {
  return RegisterFun();
});

class RegisterFun extends ChangeNotifier {
  void showSnackBar(
      {required BuildContext context,
      required String message,
      required Color backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void validateAdress(BuildContext context, {required isArabic}) {
    showSnackBar(
        context: context,
        message: isArabic
            ? "يجب اختيار عنوان على الخريطة"
            : "An address must be selected on the map.",
        backgroundColor: Colors.redAccent);
  }

  String encryptData(
      Map<String, dynamic> data, String privateKey, String publicKey) {
    final key = encrypt.Key.fromUtf8(privateKey);
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

  String? Succes = '';
  Future<void> RegisterAccount(
      {context,
      required String ArabicName,
      required String CustomerPhone,
      required String Email,
      required String LastName,
      required String PassWord,
      required String? DistrictName,
        required String? regiontName,
      required String StreetName,
      required String HouseNo,
      required String Gada,
      required String Block,
      String? placeId,
      String? customerAdress,
      String? Floor,
      String? Apartment,
      String? AddressNotes}) async {
    token = await FirebaseMessaging.instance.getToken();
    print('token $token');
    print('Register............26/2/2024.............');
    const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
    const publicKey = 'e0c9de1b2de26fe2';
    String encryptedData = encryptData({
      "ArabicName": ArabicName,
      "CustomerPhone": CustomerPhone,
      "Email": Email,
      "LastName": LastName,
      "PassWord": PassWord,
      "DistrictName": DistrictName,
      "RegionName":regiontName,
      "StreetName": StreetName,
      "HouseNo": HouseNo,
      "Gada": Gada,
      "Floor": Floor,
      "Block": Block,
      "Apartment": Apartment,
      "AddressNotes": AddressNotes,
      "Token": token,
      "MapCustomerAddress": customerAdress,
      "MapPlaceID": placeId
    }, privateKey, publicKey);
    print("Encrypted Data: $encryptedData");
    String jsonData = jsonEncode(encryptedData);
    DioHelperOneSystem.postData(url: 'api/Customer/AddCustomer', data: jsonData)
        .then((value) {
      print(value.data);
      print('Success Register');
      final decryptedText = decrypt(value.data, privateKey, publicKey);
      Succes = decryptedText;
      print(Succes.runtimeType);
      print(Succes);
      debugPrint('*' * 50);
      debugPrint("placeIdValue : $placeId  , fullAdress : $customerAdress");
      debugPrint('*' * 50);
      // CacheHelper.putData(key: 'UserPhone', value: value)
      if (Succes == 'This customer exists.') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'رقم الهاتف مسجل من قبل',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        'متابعة',
                        style: TextStyle(
                          color: Colors.white, // Set the text color to white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'تم تسجيل الحساب بنجاح',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        'متابعة',
                        style: TextStyle(
                          color: Colors.white, // Set the text color to white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }

      notifyListeners();
    }).catchError((error) {
      print('Error Register');
      print(error.toString());
    });
  }
}

//------------------------------------------------Register Governorates--------------------------------------------
final getDataGovernoratesFromApiProviderr =
    ChangeNotifierProvider((ref) => GetDataListGovernorates());

class GetDataListGovernorates extends ChangeNotifier {
  GetDataListGovernorates() {
    getDataListGovernorates();
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

  List dataGovernorates = [];

  void getDataListGovernorates() {
    DioHelperOneSystem.getData(url: 'api/Governorates').then((value) {
      print('11111111111111111111111111111111111111111111111111111');
      print('Success List Governorates');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      dataGovernorates = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(dataGovernorates);
      print(dataGovernorates[0]);

      print(dataGovernorates.length);
      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}
