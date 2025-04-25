import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymart/src/core/utils/dialog_helper.dart';
import 'package:sundaymart/src/presentation/pages/auth/login/one_system/login_screen.dart';

import '../../../../../../main.dart';
import '../../../main/main_page.dart';
import '../../../main/pickup/One System/DioOneSystem.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';

import 'CashHelper.dart';

final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
final publicKey = 'e0c9de1b2de26fe2';
final loginProviderr = ChangeNotifierProvider<LoginFun>((ref) {
  return LoginFun();
});

class LoginFun extends ChangeNotifier {
  // void showSnackBar(
  //     {required BuildContext context,
  //       required String message,
  //       required Color backgroundColor}) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       backgroundColor: backgroundColor,
  //     ),
  //   );
  // }

  void showSnackBarHelper(BuildContext context,
      {required String name, required isErro}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor:
            isErro ? const Color(0xffcc0000) : Colors.deepPurpleAccent,
        content: Text(
          name,
        )));
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

  String? Succes = '';
  void LoginUser(
      {required String CustomPhonee,
      required String PassWord,
      context,
      required isArabic}) {
    print('Login............26/2/2024.............');
    DialogHelper.showDialogHelper(context);
    DioHelperOneSystem.getData(
            url:
                'api/Customer/Login?CustomerPhone=$CustomPhonee&passWord=$PassWord&Token=$token')
        .then((value) {
      DialogHelper.closeDialogHelper(context);
      print(value.data);
      print('Success Login');

      final decryptedText = decrypt(value.data, privateKey, publicKey);
      Succes = decryptedText;
      print(Succes);
      Map<String, dynamic> mapSucces = jsonDecode(Succes!);
      print(mapSucces["CustomerPhone"]);

      saveValue(mapSucces["CustomerPhone"]);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MainPage(),
            settings: RouteSettings(name: "/login")),
      );
print('TOkEN-------${token}');
      showSnackBarHelper(context,
          isErro: false,
          name: isArabic
              ? "تم تسجيل الدخول بنجاح"
              : "You have logged in successfully");

      notifyListeners();
    }).catchError((error) {
      // DialogHelper.closeDialogHelper(context);
      showSnackBarHelper(context,
          isErro: true,
          name: isArabic
              ? "كلمة السر أو رقم المحمول غير صحيح"
              : "The password or mobile number is incorrect");
      print('Error Login');
      print(error.toString());
    });
  }
}

void saveValueToSharedPreferences(String key, dynamic value) {
  SharedPreferences.getInstance().then((prefs) {
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    } else {
      throw Exception('Unsupported value type');
    }
  });
}

dynamic getValueFromSharedPreferences(String key) {
  SharedPreferences.getInstance().then((prefs) {
    return prefs.get(key);
  });
}

Future<void> saveValue(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString('PhoneUser', value);
}
