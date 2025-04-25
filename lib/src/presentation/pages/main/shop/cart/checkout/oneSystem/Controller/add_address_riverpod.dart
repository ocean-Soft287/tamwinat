import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sundaymart/main.dart';

import 'package:sundaymart/src/presentation/pages/main/home/widget/saved_addresses.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';

import '../../../../../../../../riverpod/gh.dart';

import '../../../../../../pages.dart';
import '../../../../../drawer/MyPreviousRequests/view/my_previous_requets_screen.dart';
import '../../../../../drawer/tamwnate_pro/manager/get_subscribtions_riverpod.dart';
import '../../../../../pickup/One System/DioOneSystem.dart';

final addAddressProvider = ChangeNotifierProvider<addAddress>((ref) {
  return addAddress();
});

class addAddress extends ChangeNotifier {
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

  String? _customerAdress;

  void setAdressFromGoogleMap(
      {required String placeId, required customerAdress}) {
    _customerAdress = customerAdress;
  }

  String encryptData(
      Map<String, dynamic> data, String privateKey, String publicKey) {
    final key = encrypt.Key.fromUtf8(privateKey);
    final iv = encrypt.IV.fromUtf8(publicKey);
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

  Future<void> addAddressFu(
      {context,
        String? DistriictName,String? regionName,
        String? Block,
        String? StreetName,
        String? HouseNo,
        String? Gada,
        String? Floor,
        String? Apartment,
        String? placeIdValue,
        String? customerAdressValue}) async {
    final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
    final publicKey = 'e0c9de1b2de26fe2';
    String encryptedData = encryptData({
      "customerphone": UserPhone,
      "RegionName":regionName,
      "DistrictName": DistriictName,
      "StreetName": StreetName,
      "HouseNo": HouseNo,
      "Gada": Gada,
      "Block": Block,
      "Floor": Floor,
      "Apartment": Apartment,
      "MapCustomerAddress": customerAdressValue, // UPDATEADRESS HERE
      "MapPlaceID": placeIdValue
      // "place_id": placeIdValue, // ADDADRESS  // UPDATEADRESS HERE
      // "CustomerAddress": customerAdressValue,
    }, privateKey, publicKey);
    print("Encrypted Data: $encryptedData");
    String jsonData = jsonEncode(encryptedData);
    debugPrint('*' * 50);
    debugPrint(
        "placeIdValue : $placeIdValue  , fullAdress : $customerAdressValue");
    debugPrint('*' * 50);
    await DioHelperOneSystem.postData(
        url: 'api/Customer/AddCustomerAddress', data: jsonData)
        .then((value) {
      final text = decrypt(encryptedData, 'c104780a25b4f80c037445dd1f6947e1',
          'e0c9de1b2de26fe2');
      print("-" * 50);
      print('بعد التشفير');
      print(text);
      print("-" * 50);
      showSnackBar(
          backgroundColor: Colors.green,
          context: context,
          message: 'تم اضافه عنوان جديد');
      Navigator.pop(context);
      Navigator.pop(context);
      notifyListeners();
    }).catchError((error) {
      showSnackBar(
          backgroundColor: Colors.red,
          context: context,
          message: 'لم يتم اضافه العنوان ');
      print('Error post Order');
      print(error.toString());
    });
  }

bool editSuccess=false;
  Future<void> editAddressFu(
      {context,
        String? DistriictName,
        String? Block,
        String? StreetName,
        String? HouseNo,
        String? Gada,
        String? Floor,
        String? Apartment,
        dynamic addressId,
       required dynamic function

       }) async {
    const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
    const publicKey = 'e0c9de1b2de26fe2';
    String encryptedData = encryptData({
      "customerphone": UserPhone,
      "DistrictName": DistriictName,
      "StreetName": StreetName,
      "HouseNo": HouseNo,
      "Gada": Gada,
      "Block": Block,
      "Floor": Floor,
      "Apartment": Apartment,
       "AddressID":addressId

    }, privateKey, publicKey);

    print({
      "customerphone": UserPhone,
      "DistrictName": DistriictName,
      "StreetName": StreetName,
      "HouseNo": HouseNo,
      "Gada": Gada,
      "Block": Block,
      "Floor": Floor,
      "Apartment": Apartment,
      "AddressID":addressId

    });
    print("Encrypted Data: $encryptedData");

    String jsonData = jsonEncode(encryptedData);

    await DioHelperOneSystem.updateData(
        url: 'api/Customer/UpdateCustomerAddress', data: jsonData)
        .then((value) {
      final text = decrypt(encryptedData, 'c104780a25b4f80c037445dd1f6947e1',
          'e0c9de1b2de26fe2');
      print("-" * 50);
      print('بعد التشفير');
      print(text);
      print("-" * 50);
      showSnackBar(
          backgroundColor: Colors.green,
          context: context,
          message: 'تم تعدبل العنوان عنوان جديد');
      editSuccess=true;
      function.getAddresss();
      Navigator.pop(context);

      notifyListeners();
    }).catchError((error) {
      showSnackBar(
          backgroundColor: Colors.red,
          context: context,
          message: 'لم يتم التعديل');
      print('Error post Order');
      print(error.toString());
    });
  }



  void deleteAddress({required dynamic addressILd,required BuildContext context,  required isArabic}){
    DioHelperOneSystem.delelet(url: 'api/Customer/DeleteCustomerAddress?CustomerPhone=$UserPhone&AddressID=$addressILd').

    then((value) {

      print(value.data);

      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor:
          Colors.deepPurpleAccent,
          content: Text(
            isArabic?
            'تم الحذف بنجاح'
                :"Deleted successfully.",
          )));


      // Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context){
      //
      //   return SavedAddresses();
      //
      // }), (route) => false);
    }).catchError((error)



    {

      print(error.toString());


    }

    );
  }
}