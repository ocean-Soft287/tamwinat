import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:sundaymart/src/core/utils/dialog_helper.dart';

import 'package:sundaymart/src/presentation/pages/main/pickup/One%20System/DioOneSystem.dart';

final getForgetPasswordApiProvider =
    ChangeNotifierProvider((ref) => GetForgetPasswordApi());

class GetForgetPasswordApi extends ChangeNotifier {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  void resetControllerData() {
    phoneController.clear();
    emailController.clear();
  }

  String? validateField(String? value, {required bool isArabic}) {
    if (value == null || value.isEmpty) {
      return isArabic ? "من فضلك ادخل الحقل" : "Please enter the field";
    }
    return null;
  }

  String? validateEmail(String? value, {required bool isArabic}) {
    // r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$
    // r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\.]+\.(com|pk)+"
    final RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    if (value != null && value.isNotEmpty && emailRegex.hasMatch(value)) {
      return null;
    } else {
      return isArabic ? "يرجي إدخال إيميل صالح" : "Please enter a valid email";
    }

    // ^\+(?:[0-9]●?){6,14}[0-9]$
  }

  void validateForm(BuildContext context, {required bool isArabic}) async {
    if (formKey.currentState!.validate()) {
      // formKey.currentState!.validate()

      DialogHelper.showDialogHelper(context);

      _forgetPasswordService(context, isArabic: isArabic);
    }
  }

  String? validatePhoneNumber(String? value, {required bool isArabic}) {
    if (value!.isEmpty) {
      return isArabic ? 'هذا الحقل مطلوب' : 'This field is required';
    } else if (value.length != 8 ||
        !(value.startsWith('4') ||
            value.startsWith('5') ||
            value.startsWith('6') ||
            value.startsWith('9'))) {
      return isArabic
          ? "رقم الهاتف غير صحيح او الارقام لا تحتوي علي ارقام انجليزية"
          : 'The Mobile Number not correct please check the mobile number';
    } else {
      return null;
    }
  }

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
    final keyObj = encrypt.Key.fromUtf8(privateKey);
    final ivObj = encrypt.IV.fromUtf8(publicKey);
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

//////////////////////////////////////////////////// Service ////////////////////////////////////////////////////////////////

  void _forgetPasswordService(BuildContext context,
      {required bool isArabic}) async {
    await DioHelperOneSystem.getData(
            url:
                'api/Customers/ForgetPassword?CustomerPhone=${phoneController.text}&Email=${emailController.text}')
        .then((value) async {
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';
      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      bool isSendForgetPasswordSucess = (jsonDecode(decryptedText))
          .toString()
          .trim()
          .contains("Password sent  to your Email");

      print("*" * 50);
      print('بعد التشفير');
      print("isSendForgetPasswordSucess : $isSendForgetPasswordSucess");
      print(decryptedText);
      print("*" * 50);

      DialogHelper.closeDialogHelper(context);

      if (!isSendForgetPasswordSucess) {
        showSnackBarHelper(context,
            name: isArabic
                ? "حدث خطأ أثناء استعادة كلمة السر قد يكون المعلومات التي أدخلتها غير صحيحة"
                : "An error occurred during password recovery. The information you entered may be incorrect.",
            isErro: true);
      } else {
        Navigator.of(context).pop();
        showSnackBarHelper(context,
            name: isArabic // "تم إرسال كلمة السر بنجاح علي هذا الإيميل ${emailController.text}"
                ? "تم إرسال كلمة السر بنجاح علي الإيميل الخاص بك"
                : "The password has been sent Success to your email", // "The password has been sent Success to this email: ${emailController.text}"
            isErro: false);
        Navigator.of(context).pop();
      }

      // notifyListeners();
    }).catchError((error) {
      DialogHelper.closeDialogHelper(context);
      showSnackBarHelper(context,
          name: isArabic
              ? "حدث خطأ أثناء استعادة كلمة السر قد يكون المعلومات التي أدخلتها غير صحيحة"
              : "An error occurred during password recovery. The information you entered may be incorrect.",
          isErro: true);
    });
  }
}
