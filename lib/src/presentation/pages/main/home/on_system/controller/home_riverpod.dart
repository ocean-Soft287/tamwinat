import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sundaymart/main.dart';

import '../../../pickup/One System/DioOneSystem.dart';

final getProductsFromApi =
    ChangeNotifierProvider((ref) => GetProductsDataFromApi());

class GetProductsDataFromApi extends ChangeNotifier {
  // GetDataFromApi() {
  //   getCategoryItem(categoryId: categoryId);
  // }

  resetController() {
    productsList.clear();
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
bool iSLoading=true;
  List<Map<String, dynamic>> productsList = [];

  void setProducts({List<Map<String, dynamic>>? productListValue}) {
    productsList = productListValue ?? [];
    notifyListeners();
  }

  Future<void> getProducsts({required categoryId, required brandId}) async {
    resetController();
    brandId = brandId ?? ""; // to solve erro from server
    // ${categoryId}
    // api/Product/GetBrandsByCatgory?categoryId=${categoryId}&pageNumber=1&pageSize=100000&CustomerPhone=${UserPhoneAll}&BrandID=$brandId
    await DioHelperOneSystem.getData(
            url:
                'api/Product/GetBrandsByCatgory?categoryId=$categoryId&pageNumber=1&pageSize=100000&CustomerPhone=${UserPhone??UserPhoneAll}&BrandID=$brandId')
        .then((value) {
      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print("*" * 100);
      print('بعد التشفير');
      print("Get Product by  brandId :$brandId , categoryId: $categoryId");

      print(decryptedText);
      print("*" * 100);
      productsList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      iSLoading=false;
      // notifyListeners();
    }).catchError((error, s) {
      print("*" * 100);
      print(' Error Ocurred in getCategoryItem = ${error.toString()}');
      print("Get Product by  brandId :$brandId , categoryId: $categoryId");

      print("*" * 100);
    });
  }
}

//-------------------------------------------------CategoryAlll------------------------------------------

final getDataCategoryAllFromApiProvider =
    ChangeNotifierProvider((ref) => GetDataCategoryAllFromApi());

class GetDataCategoryAllFromApi extends ChangeNotifier {
  GetDataCategoryAllFromApi() {
    getCategoryAll();
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

  List<Map<String, dynamic>> categoryAllList = [];
  void getCategoryAll() {
    DioHelperOneSystem.getData(url: 'api/Category').then((value) {
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      print("*" * 50);
      print("getCategoryAll");
      print('بعد التشفير');
      print(decryptedText);
      print("*" * 50);

      categoryAllList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(categoryAllList.length);
      print(categoryAllList[1]);

      notifyListeners();
    }).catchError((error) {
      print(' Error  Occured in  getCategoryAll 146Line = $error');
    });
  }
}

//---------------------------------------Image Banar 1----------------------------
final getImageBanarOneApiProvider =
ChangeNotifierProvider((ref) => GetImageBanarOneAllFromApi());

class GetImageBanarOneAllFromApi extends ChangeNotifier {
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

  List<Map<String, dynamic>> imageBanarOneList = [];
  void getImageBanarOne() {
    DioHelperOneSystem.getData(url: 'api/Baner1').then((value) {
      print('getFavorite');
      print('getFavorite');
      print('Success');
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

      imageBanarOneList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(imageBanarOneList.length);
      print(imageBanarOneList[1]);

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}

//-----------------------------------------Image Banar2--------------------
final getImageBanartwoApiProvider =
ChangeNotifierProvider((ref) => GetImageBanartwoAllFromApi());

class GetImageBanartwoAllFromApi extends ChangeNotifier {
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

  List<Map<String, dynamic>> imageBanartwoList = [];
  void getImageBanartwo() {
    DioHelperOneSystem.getData(url: 'api/Baner2').then((value) {
      print('getFavorite');
      print('getFavorite');
      print('Success');
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

      imageBanartwoList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(imageBanartwoList.length);
      print(imageBanartwoList[1]);

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}

//-----------------------------------------Image Banar3--------------------
final getImageBanarThreeApiProvider =
ChangeNotifierProvider((ref) => GetImageBanarthreeAllFromApi());

class GetImageBanarthreeAllFromApi extends ChangeNotifier {
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

  List<Map<String, dynamic>> imageBanarthreeList = [];
  void getImageBanarthree() {
    DioHelperOneSystem.getData(url: 'api/Baner3').then((value) {
      print(value.data);

      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('*************' * 50);
      print('بعد التشفير');
      print("Banner 3");
      print(decryptedText);
      print('*************' * 50);

      imageBanarthreeList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(imageBanarthreeList.length);

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}


//-------------------------------------------------GetMainCategory---------------------------------

final getDataGetMainCategoryApiProvider =
    ChangeNotifierProvider((ref) => GetMainCategoryAllFromApi());

class GetMainCategoryAllFromApi extends ChangeNotifier {
  GetMainCategoryAllFromApi() {
    getMainCategory();
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

  List<Map<String, dynamic>> mainCategoryList = [];
  void getMainCategory() {
    DioHelperOneSystem.getData(url: 'api/Category/GetMainCategory')
        .then((value) {

      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);


      mainCategoryList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(mainCategoryList.length);
      print('GAMMMMMMMMMMMMMMMMMMMMMMM');
      print(mainCategoryList[1]);

      notifyListeners();
    }).catchError((error) {
      print(' Error  Occured in  Get Main Category 206 Line = $error');
    });
  }
}

//---------------------------------------------------GetCategoryByParentId--------------------

final getDataCategoryByParentIdApiProvider =
    ChangeNotifierProvider((ref) => GetCategoryByParentIdAllFromApi());

class GetCategoryByParentIdAllFromApi extends ChangeNotifier {
  dynamic categoryId;
  GetCategoryByParentIdAllFromApi() {
    getCategoryByParentId(categoryId: categoryId);
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

  List<Map<String, dynamic>> categoryByParentIdList = [];

  bool isSelectedAll({required int index}) {
    if (categoryByParentIdList[index]['CategoryArName']
            .toString()
            .toLowerCase()
            .contains("الكل") ||
        categoryByParentIdList[index]['CategoryEnName']
            .toString()
            .toLowerCase()
            .contains("all")) {
      return true;
    } else {
      return false;
    }
  }

  void getCategoryByParentId({required categoryId}) {
    //
    DioHelperOneSystem.getData(
            url: 'api/Category/GetCategoryByParentId?Parent=${categoryId}')
        .then((value) {
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print("*" * 50);
      print("getCategoryByParentId $categoryId");
      print('بعد التشفير');
      print(decryptedText);
      print('*************');
      print("*" * 50);
      categoryByParentIdList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(categoryByParentIdList.length);
      print(categoryByParentIdList[1]);

      notifyListeners();
    }).catchError((error) {
      print(' Error  Occured in  Get  Category by Parent 263 Line = $error');
    });
  }
}
// -------------------------------------------------------------------------------
//---------------------------------------------------GetBrandsByCategoryId--------------------

final getBrandCategoryApiProvider =
    ChangeNotifierProvider((ref) => GetBrandCategoryByCategoryIdAllFromApi());

class GetBrandCategoryByCategoryIdAllFromApi extends ChangeNotifier {
  dynamic categoryId;
  GetCategoryByParentIdAllFromApi() {
    getBrandCategoryByCategoryId(categoryId: categoryId);
  }

  resetController() {
    brandCategoryList.clear();
    tempProductList.clear();
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

  List<Map<String, dynamic>> brandCategoryList = [];
  List<Map<String, dynamic>> tempProductList =
      []; // to get it during load the page in the FirstTime
  Future<void> getBrandCategoryByCategoryId({required categoryId}) async {
    resetController();

    //  'api/Product/GetBrandsByCatgory?categoryId=${categoryId}&pageNumber=1&pageSize=100000&&CustomerPhone=${UserPhone}'
    // 'api/Product/GetBrandsByCatgory?categoryId=${categoryId}&pageNumber=1&pageSize=10000&CustomerPhone=${UserPhoneAll}'
    await DioHelperOneSystem.getData(
            url:
                'api/Product/GetBrandsByCatgory?categoryId=${categoryId}&pageNumber=1&pageSize=100000&CustomerPhone=${UserPhone??UserPhoneAll}')
        // 'api/Product/GetBrandsByCatgory?categoryId=${categoryId}&pageNumber=1&pageSize=10000&CustomerPhone=${UserPhoneAll})
        .then((value) {
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';
// g8Etyx8TU579vDxJzaN1lo3r46+WJLvqb/IMYdIURHM=
      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      print("*" * 50);
      print('getBrand by categoryId:$categoryId');
      print('بعد التشفير');
      print(decryptedText);
      print(brandCategoryList.length);
      print('*************');
      print("*" * 50);

      brandCategoryList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print("-" * 100);
      tempProductList = (brandCategoryList[0]['Products'] as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      brandCategoryList = (brandCategoryList[0]['Brands'] as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();

      print(brandCategoryList);
      print(tempProductList);
      print("/" * 100);
      print('99999999999999999999999999999999999999999999');
           print(brandCategoryList);
      print('988888888888888888888888888888888888888888888');
      notifyListeners();
    }).catchError((error) {
      print(' Error  Occured in  Get Brand  323 Line = $error');
    });

    // List<Map<String, dynamic>> tempList =
    //     (brandCategoryList[0]['Products'] as List<dynamic>)
    //         .map((item) => item as Map<String, dynamic>)
    //         .toList();
    // print("5" * 100);
    // print(tempList);
    // print("5" * 100);
    // return (brandCategoryList[0]['Products'] as List<dynamic>)
    //     .map((item) => item as Map<String, dynamic>)
    //     .toList();
  }
}

//---------------------------------------Best Seller-----------------------------

final getDataBestSellerFromApiProvider =
    ChangeNotifierProvider((ref) => GetDataBestSellerFromApi());

class GetDataBestSellerFromApi extends ChangeNotifier {
  GetDataBestSellerFromApi() {
    getBestSeller();
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

  List<Map<String, dynamic>> bestSellerList = [];
  void getBestSeller() {
    DioHelperOneSystem.getData(
            url:
                'api/Product/GetProductsWithBestSeller?pageNumber=1&pageSize=100&CustomerPhone=${UserPhone??UserPhoneAll}')
        .then((value) {
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      bestSellerList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(bestSellerList);
      print(bestSellerList[0]["ColorArName"]);
      print(bestSellerList[0]["BarCode"]);
      print(bestSellerList[0]);
      print('00000000000000');
      print(bestSellerList);
      print('11111111111111111111');
      print(bestSellerList[2]);
      print(bestSellerList.length);
      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }

  List<Map<String, dynamic>> categoryAllList = [];
  void getCategoryAll() {
    DioHelperOneSystem.getData(url: 'api/Category').then((value) {
      print('CategoryAl');
      print('CategoryAl');
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      categoryAllList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(categoryAllList);

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}

//---------------------------------------With Biggest Discount---------------------------------------
final getDataBiggestDiscountFromApiProvider =
    ChangeNotifierProvider((ref) => GetDataBiggestDiscountFromApi());

class GetDataBiggestDiscountFromApi extends ChangeNotifier {
  GetDataBiggestDiscountFromApi() {
    getGetDataBiggestDiscount();
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

  List<Map<String, dynamic>> BiggestDiscountList = [];
  void getGetDataBiggestDiscount() {
    DioHelperOneSystem.getData(
            url:
                'api/Product/GetProductsWithBiggestDiscount?pageNumber=1&pageSize=100&CustomerPhone=${UserPhone??UserPhoneAll}')
        .then((value) {
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      BiggestDiscountList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(BiggestDiscountList);

      print('00000000000000');
      print(BiggestDiscountList);
      print('11111111111111111111');
      print(BiggestDiscountList[2]);
      print(BiggestDiscountList.length);
      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }

  List<Map<String, dynamic>> categoryAllList = [];
  void getCategoryAll() {
    DioHelperOneSystem.getData(url: 'api/Category').then((value) {
      print('CategoryAl');
      print('CategoryAl');
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      categoryAllList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(categoryAllList);

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}

//------------------------------------------Events version---------
final getDataProductVersionFromApiProvider =
    ChangeNotifierProvider((ref) => GetDataProductVersionFromApi());

class GetDataProductVersionFromApi extends ChangeNotifier {
  GetDataProductVersionFromApi() {
    getProductVersion();
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

  List<Map<String, dynamic>> productVersionList = [];
  void getProductVersion() {
    DioHelperOneSystem.getData(
            url: 'api/Product/GetNewProducts?pageNumber=1&pageSize=100&CustomerPhone=${UserPhone??UserPhoneAll}')
        .then((value) {
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      productVersionList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(productVersionList);
      print(productVersionList[0]["ColorArName"]);
      print(productVersionList[0]["BarCode"]);
      print(productVersionList[0]);
      print('00000000000000');
      print(productVersionList);
      print('11111111111111111111');
      print(productVersionList[2]);
      print(productVersionList.length);
      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }

  List<Map<String, dynamic>> categoryAllList = [];
  void getCategoryAll() {
    DioHelperOneSystem.getData(url: 'api/Category').then((value) {
      print('CategoryAl');
      print('CategoryAl');
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      categoryAllList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(categoryAllList);

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}

//N------------------------------------آNews----------------------
final getDataNewsFromApiProvider =
    ChangeNotifierProvider((ref) => GetDataNewsFromApi());

class GetDataNewsFromApi extends ChangeNotifier {
  GetDataNewsFromApi() {
    getNews();
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

  List<Map<String, dynamic>> newsList = [];
  void getNews() {
    DioHelperOneSystem.getData(url: 'api/News').then((value) {
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      newsList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(newsList);

      print('00000000000000');
      print(newsList);
      print('11111111111111111111');

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }

  List<Map<String, dynamic>> categoryAllList = [];
  void getCategoryAll() {
    DioHelperOneSystem.getData(url: 'api/Category').then((value) {
      print('CategoryAl');
      print('CategoryAl');
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      categoryAllList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(categoryAllList);

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}

//-----------------------------------------Over One dynamic  -------------------------------
final getDataOverOneFromApiProvider =
    ChangeNotifierProvider((ref) => GetDataOverOneFromApi());

class GetDataOverOneFromApi extends ChangeNotifier {
  GetDataOverOneFromApi() {
    getOverOe();
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

  List<Map<String, dynamic>> overOneList = [];
  void getOverOe() {
    DioHelperOneSystem.getData(url: 'api/Offer1?CustomerPhone=${UserPhone??UserPhoneAll}').then((value) {
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      overOneList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(overOneList);

      print('00000000000000');

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }
}

//--------------------------------------Over two  dynamic -----------------------------------------
final getDataOverTwoFromApiProvider =
    ChangeNotifierProvider((ref) => GetDataOverTwoFromApi());

class GetDataOverTwoFromApi extends ChangeNotifier {
  GetDataOverTwoFromApi() {
    getOverTwo();
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

  List<Map<String, dynamic>> overTwoList = [];
  void getOverTwo() {
    DioHelperOneSystem.getData(url: 'api/Offers?CustomerPhone=${UserPhone??UserPhoneAll}').then((value) {
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');

      overTwoList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(overTwoList);

      print('000000000 Get Offers 00000');

      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000 Offers    00000000000000000');
    });
  }
}
