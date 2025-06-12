import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/fatora_page.dart';
import '../../../../../../../theme/app_colors.dart';
import '../../../../../pickup/One System/DioOneSystem.dart';

final orderItemProvider = ChangeNotifierProvider<OrderItemFun>((ref) {
  return OrderItemFun();
});

class OrderItemFun extends ChangeNotifier {
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

  String? Succes = '';

  void orderItemFu(
      {required BuildContext context,
      required List<Map<String, dynamic>> Image,
      required String OrderDate,
      required String CustomerPhone,
      required String CustomerName,
      String? DistriictName,
      String? regionName,
      String? Block,
      String? Street,
      String? House,
      String? Gada,
      String? Floor,
      String? Apartment,
      String? DiscountCode,
      required String Email,
      required String DeliveryDate,
      required String DeliveryDay,
      required String OrderTime,
      required num Additions,
      required num TotalValue,
      required num Discount,
      required num FinalValue,
      required num PayID,
      required num OnlineStoreId,
      required int DeliveryID,
      required String Details,
      required dynamic DiscountCardValue,
      required List<Map<String, dynamic>> orderList,
      String? CustomerAddress,
      String? customerMapAdress,
      String? placeId,
      dynamic paymentMethodeWalet,
      dynamic discountPointsValue}) {
    const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
    const publicKey = 'e0c9de1b2de26fe2';
    String encryptedData = encryptData(
      {
      "OrderDate": OrderDate,
      "CustomerPhone": CustomerPhone,
      "CustomerName": CustomerName,
      "DistrictName": DistriictName,
      if (UserPhone == null) "RegionName": regionName,
      "Block": Block,
      "Street": Street,
      "House": House,
      "Gada": Gada,
      "Floor": Floor,
      "Apartment": Apartment,
      "Email": Email,
      "TotalValue": TotalValue,
      "Discount": Discount,
      "FinalValue": FinalValue,
      "PayID": PayID,
      "OnlineStoreId": OnlineStoreId,
      "DeliveryDate": DeliveryDate,
      "DeliveryDay": DeliveryDay,
      "OrderTime": OrderTime,
      "Additions": Additions,
      "DeliveryID": DeliveryID,
      "Details": Details,
      "CustomerAddress": CustomerAddress,
      "DiscountCode": DiscountCode,
      "DiscountCardValue": DiscountCardValue,
      "MapCustomerAddress": customerMapAdress, // UPDATEADRESS HERE
      "MapPlaceID": placeId,
      "DiscountPointsValue": discountPointsValue ?? 0,
      "OrderItems": orderList,
    }, privateKey, publicKey);
  //  debugPrint("Encrypted Data: $encryptedData");
  //  final decryptedText1 = decrypt(encryptedData, privateKey, publicKey);
   log( encryptedData); //g8Etyx8TU579vDxJzaN1lo3r46+WJLvqb/IMYdIURHM=

    String jsonData = jsonEncode(encryptedData);
    debugPrint('5555555555');
    final decryptedText = decrypt(encryptedData, privateKey, publicKey);
    debugPrint('222222');

    log('------------------------------------------');
   // log(jsonData);
    log('********************************************');
    log(decryptedText);
    log('********************************************');
    // updated Here
    DioHelperOneSystem.postData(url: 'api/Order', data: jsonData).then((value) {
      final decryptedText2 = decrypt(value.data, privateKey, publicKey);
      debugPrint(decryptedText2);
    //  debugPrint(value.data);
      debugPrint('Success post Order');
      // Succes=value.data;
      final decryptedText = decrypt(value.data, privateKey, publicKey);
      Succes = decryptedText;
      showSnackBar(
          backgroundColor: Colors.black,
          context: context,
          message: 'تم تسجيل الطلبيه بنجاح');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Fatora(
                discountPointsValue: discountPointsValue ?? 0,
                addressCustoomer: CustomerAddress,
                address: CustomerAddress??"",
                gada: Gada ?? '',
                delivery: Additions,
                payId: PayID,
                listIteamFatora: orderList,
                data: OrderDate,
                time: OrderDate,
                regionName: regionName ?? '',
                totalValue: TotalValue,
                discount: Discount,
                finalValue: FinalValue,
                listImageFatora: Image,
                DeliveryDay: DeliveryDay,
                DeliveryData: DeliveryDate,
                ordeTime: OrderTime,
                numberFaota: Succes!,
                phone: CustomerPhone,
                block: Block ?? '',
                distrubit: DistriictName ?? '',
                name: CustomerName,
                Strate: Street ?? '',
                House: House ?? '',
                Details: Details ?? '',
                ValueFi: FinalValue,
                Floor: Floor ?? '',
                Apartment: Apartment ?? '',
                paymentMethodeWalet: paymentMethodeWalet)),
      );

      notifyListeners();
    }).catchError((error) {
      debugPrint("Generated Error ${error.toString()}");
      showSnackBar(
          backgroundColor: Colors.red,
          context: context,
          message: 'خطاء فى تسجيل الطلبيه حاول مره اخرى');
      print('Error post Order');
      print(error.toString());
    });
  }
}

//-----------------------------------------------------------------------------------

class NewListItem extends ChangeNotifier {
  List<Map<String, dynamic>> _newList = [];

  List<Map<String, dynamic>> get newList => List.unmodifiable(_newList);

  void addItem(Map<String, dynamic> newItem) {
    _newList.add(newItem);
    notifyListeners();
  }
}

final newOrderProviderList = ChangeNotifierProvider<NewListItem>((ref) {
  return NewListItem();
});

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


//---------------------------------------------------------List Address---------
final getDataFromApiProviderr =
    ChangeNotifierProvider((ref) => GetDataListAddress());

class GetDataListAddress extends ChangeNotifier {
  GetDataListAddress() {
    getDataListAddress(governorateId: 4);
    getGovernoratesList();
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

  List dataAddressList = [];

  void getDataListAddress({required var governorateId}) {
    dataAddressList = [];
    DioHelperOneSystem.getData(
            url:
                'api/Areas/GetAreaByGovernorateId?GovernorateId=$governorateId')
        .then((value) {
      print('11111111111111111111111111111111111111111111111111111');
      print('Success List Address');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      dataAddressList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(dataAddressList);
      print(dataAddressList[0]);

      print(dataAddressList.length);
      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }

  List governoratesList = [];
  void getGovernoratesList() {
    DioHelperOneSystem.getData(url: 'api/Governorates').then((value) {
      print('========================= Start =========================');
      print('Success Governorates List');
      print(value.data);
      print('========================== End ==========================');

      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      // فك تشفير النص
      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      // تحويل البيانات إلى قائمة
      governoratesList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();

      // طباعة البيانات للتأكد
      print(governoratesList);
      if (governoratesList.isNotEmpty) {
        print(governoratesList[0]);
      }
      print('Governorates count: ${governoratesList.length}');

      // إخطار المستمعين
      notifyListeners();
    }).catchError((error) {
      print('Error occurred: $error');
      print('=================== Error End ====================');
    });
  }
}

//--------------------------------------------discount code------------------
final discountCodeFromApiProvider =
    ChangeNotifierProvider((ref) => GetDiscountCodeFromApi());
class GetDiscountCodeFromApi extends ChangeNotifier {
  dynamic decrypt(dynamic encryptedText, String privateKey, String publicKey) {
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
      return null;
    }
  }

  String encryptData(dynamic plainText, String privateKey, String publicKey) {
    final keyObj = encrypt.Key.fromUtf8(privateKey);
    final ivObj = encrypt.IV.fromUtf8(publicKey);
    final encrypter =
    encrypt.Encrypter(encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));

    try {
      final encrypted = encrypter
          .encrypt(plainText, iv: ivObj)
          .base64;
      return encrypted;
    } catch (e) {
      print("Error encrypting data: $e");
      return '';
    }
  }

  List<Map<String, dynamic>> discountCodeList = [];
  bool isLoading = false;


  Future<void> getDiscountCode({
    required BuildContext context,
    required String discountCode,
    required String customerPhone,
    required List<Map<String, dynamic>> orderList,
  }) async {
    isLoading = true;
    notifyListeners();

    // Filtered Order List
    final filteredOrderList = orderList.map((item) {
      return {
        "ItemID": item["ItemID"],
        "Quantity": item["Quantity"],
        "Price": item["Price"],
        "BarCode": item["BarCode"],
      };
    }).toList();

    const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
    const publicKey = 'e0c9de1b2de26fe2';

    // Request Data
    final requestData = {
      "DiscountCode": discountCode,
      "CustomerPhone": customerPhone,
      "OrderItems": filteredOrderList,
    };

    // Serialize the requestData to JSON String
    final requestDataString = jsonEncode(requestData);

    // Encrypt requestDataString
    final encryptedRequest;
    try {
      encryptedRequest = encryptData(requestDataString, privateKey, publicKey);
 print("encryptedRequest:${encryptedRequest}");
    } catch (e) {
      print('Error encrypting data: $e');
      return; // Exit early if encryption fails
    }

    print("encryptedRequest$encryptedRequest");
    final jsonData = jsonEncode(encryptedRequest);

    try {
      final response = await DioHelperOneSystem.postData(
        url: 'api/Coupons/GetCouponsDiscount',
        data: jsonData,
      );

      isLoading = false;

      // Decrypt the  response data
      final decryptedText = decrypt(response.data, privateKey, publicKey);
      print("decryptedText: $decryptedText");

      if (decryptedText == null) {
        return;
      }

      print(' البيانات بعد فك التشفير: $decryptedText');

      if (decryptedText.trim() == 'This Coupon has been used before') {
        print(' الكود مستخدم مسبقًا.');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 28),
                  const SizedBox(width: 10),
                  Text(
                    ' كود الخصم',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Monadi',
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              content: Text(
                'كود الخصم مستخدم سابقًا',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Monadi',
                  color: AppColors.black,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Text(
                      'حسناً',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Monadi',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        try {
          // Deserialize decryptedText to update discountCodeList
          discountCodeList = List<Map<String, dynamic>>.from(json.decode(decryptedText));
          print(' القائمة بعد التحديث: $discountCodeList');
        } catch (e) {
          print(' خطأ أثناء تحليل البيانات: $e');
          discountCodeList.clear();
        }
      }
    } catch (error) {
      isLoading = false;
      discountCodeList.clear();
      print(' خطأ أثناء جلب البيانات: $error');
    } finally {
      notifyListeners();
    }
  }
}