import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sundaymart/main.dart';

import 'package:sundaymart/src/core/utils/dialog_helper.dart';

import 'package:sundaymart/src/presentation/pages/main/pickup/One%20System/DioOneSystem.dart';
import 'package:sundaymart/src/presentation/pages/main/pickup/One%20System/riverpodOneSystem/notifierOneSystem.dart';

final getUpdateAccountApiProvider =
    ChangeNotifierProvider((ref) => GetUpdateAccountApi());

class GetUpdateAccountApi extends ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> userInformation = {};

  bool isLoadUpdateAccountPage = false;

  getFromApiData(BuildContext context) {
    resetControllerData();
    getProfileSettings(phone: UserPhone??'', context: context);
  }

  void resetControllerData() {
    if (userInformation.isNotEmpty) {
      phoneController.text = userInformation['CustomerPhone'];
      firstNameController.text = "${userInformation['ArabicName']}";
      lastNameController.text = "${userInformation['LastName']}";

      emailController.text = userInformation['Email'];
    }
  }

  void _updateUserInformation(
      {required String firstName,
      required String lastName,
      required String phone,
      required String email}) {
    userInformation['EnglishName'] = firstName;
    userInformation['LastName'] = lastName;
    userInformation['Email'] = email;
    userInformation['CustomerPhone'] = phone;
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
      print("Sucess");
      DialogHelper.showDialogHelper(context);
      updateAcountService(context, isArabic: isArabic);

      //  changePasswordService(context, isArabic: isArabic);
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

  void getProfileSettings(
      {required String phone, required BuildContext context}) {
    DioHelperOneSystem.getData(
            url: 'api/Customers/GetCustomer?CustomerPhone=$phone')
        .then((value) {
      print('getProfileSettings');
      print('getProfileSettings');
      print('Success');
      print('مشفرره');
      print(value.data);
      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('*************');
      print('بعد التشفير');

      userInformation = jsonDecode(decryptedText)[0];
      print(userInformation);
      resetControllerData();
      print('*************');
      isLoadUpdateAccountPage = true;

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('11111111');
    });
  }

  void updateAcountService(BuildContext context,
      {required bool isArabic}) async {
    final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
    final publicKey = 'e0c9de1b2de26fe2';
    print({
      "ArabicName": firstNameController.text,
      "LastName": lastNameController.text,
      "customerphone": phoneController.text,
      "email": emailController.text,
    });
    String encryptedData = encryptData({
      "ArabicName": firstNameController.text,
      "LastName": lastNameController.text,
      "customerphone": phoneController.text,
      "email": emailController.text,
    }, privateKey, publicKey);
    print("Encrypted Data: $encryptedData");
    String jsonData = jsonEncode(encryptedData);

    // await DioHelperOneSystem.updateData(
    //         url: 'api/Customer/UpdateCustomer', data: jsonData)
    // url:
    //   fas'api/Customer/ChangePassword?CustomerPhone=${UserPhone}&OldpassWord=$&NewpassWord=${newPassWordController.text}')
    await Dio(BaseOptions(headers: {
      'Authorization':
          'Basic ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ==',
      'Content-Type': 'application/json',
    }))
        .put("http://37.34.242.173:9292/TheOneAPI/api/Customer/UpdateCustomer",
            data: jsonData)
        .then((value) async {
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      bool isWrongPassword =
          (decryptedText.toString().trim().toLowerCase().contains("erro") ||
              decryptedText.toString().trim().toLowerCase().contains("wrong"));

      print('بعد التشفير');
      print(decryptedText);
      print(isWrongPassword);
      //  userInformation = decryptedText;
      _updateUserInformation(
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: phoneController.text,
      );
      // resetControllerData();
      print('*************');

      DialogHelper.closeDialogHelper(context);

      if (isWrongPassword) {
        showSnackBarHelper(context,
            name: isArabic
                ? "حدث خطأ أثناء تغيير معلومات حسابك قد يكون الإيميل مستخدم من قبل"
                : "An error occurred while changing your account information. The email may have been used before.",
            isErro: true);
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).pop();

        showSnackBarHelper(context,
            name: isArabic
                ? "تم تحديث معلومات حسابك بنجاح"
                : "Your account information has been updated successfully",
            isErro: false);
      }

      // notifyListeners();
    }).catchError((error) {

      DialogHelper.closeDialogHelper(context);
      showSnackBarHelper(context,
          name: isArabic
              ? "حدث خطأ أثناء تغيير معلومات حسابك قد يكون الإيميل مستخدم من قبل"
              : "An error occurred while changing your account information. The email may have been used before.",
          isErro: true);
    });
  }
}
