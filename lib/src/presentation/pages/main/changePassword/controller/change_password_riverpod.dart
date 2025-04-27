

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sundaymart/main.dart';

import 'package:sundaymart/src/core/utils/dialog_helper.dart';

import 'package:sundaymart/src/presentation/pages/main/pickup/One%20System/DioOneSystem.dart';

final getCahngePasswordApiProvider =
    ChangeNotifierProvider((ref) => GetChangePasswordromApi());

class GetChangePasswordromApi extends ChangeNotifier {
  TextEditingController oldpassWordController = TextEditingController();
  TextEditingController newPassWordController = TextEditingController();
  TextEditingController confirmNewPassWordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  GetChangePasswordromApi() {
    resetController();
  }

  void resetController() {
    oldpassWordController.clear();
    newPassWordController.clear();
    confirmNewPassWordController.clear();
  }

  String? validatePasword(String? value, {required bool isArabic}) {
    if (value == null || value.isEmpty) {
      return isArabic ? "من فضلك ادخل الحقل" : "Please enter the field";
    }
    return null;
  }

  String? validateConfirmPasword(String? value, {required bool isArabic}) {
    if (value == null || value.isEmpty) {
      return isArabic ? "من فضلك ادخل الحقل" : "Please enter the field";
    } else if (value != newPassWordController.text) {
      return isArabic
          ? "كلمة السر غير متطابقتين"
          : "The password does not match";
    }
    return null;
  }

  void validateForm(BuildContext context, {required bool isArabic}) async {
    if (formKey.currentState!.validate()) {
      // formKey.currentState!.validate()
      DialogHelper.showDialogHelper(context);

      changePasswordService(context, isArabic: isArabic);
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

  void changePasswordService(BuildContext context,
      {required bool isArabic}) async {
    await DioHelperOneSystem.getData(
            url:
                'api/Customer/ChangePassword?CustomerPhone=${UserPhone}&OldpassWord=${oldpassWordController.text}&NewpassWord=${newPassWordController.text}')
        .then((value) async {
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      bool isWrongPassword =
          (decryptedText.toString().trim() == "Wrong Old Password");

      DialogHelper.closeDialogHelper(context);

      if (isWrongPassword) {
        showSnackBarHelper(context,
            name: isArabic
                ? "كلمة المرور القديمة خاطئة"
                : "Old password is wrong",
            isErro: true);
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).pop();

        showSnackBarHelper(context,
            name: isArabic
                ? "تم تغيير كلمة السر بنجاح"
                : "Password changed successfully",
            isErro: false);
      }

      // notifyListeners();
    }).catchError((error) {
      DialogHelper.closeDialogHelper(context);
      showSnackBarHelper(context,
          name:
              isArabic ? "كلمة المرور القديمة خاطئة" : "Old password is wrong",
          isErro: true);
    });
  }
}
