import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sundaymart/main.dart';
import '../../../../../pickup/One System/DioOneSystem.dart';

final getDataCategoryByIdFromApiProvider =
    ChangeNotifierProvider((ref) => GetDataCategoryByIdFromApi());

class GetDataCategoryByIdFromApi extends ChangeNotifier {
  dynamic productId;
  GetDataCategoryByIdFromApi() {
    getCategoryById(productId: productId);
  }
  dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
    final keyObj = encrypt.Key.fromUtf8(privateKey); // 32 chars
    final ivObj = encrypt.IV.fromUtf8(publicKey); // 16 chars
    final encrypter = encrypt.Encrypter(encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));

    try {
      final decrypted = encrypter
          .decrypt(encrypt.Encrypted.fromBase64(encryptedText), iv: ivObj);
      return decrypted;
    } catch (e) {
      return 'Error....................';
    }
  }

  List<Map<String, dynamic>> categoryDateByIdList = [];
  void getCategoryById({required productId}) {
    DioHelperOneSystem.getData(
            url:
                'api/Product/GetProductById?ProductId=$productId&CustomerPhone=$UserPhone')
        .then((value) {
     
      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
       debugPrint(decryptedText);
     

      categoryDateByIdList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
     notifyListeners();
    }).catchError((error) {
    });
   

  }
}

//......................Search............................

final searchByIdProvider =
    StateNotifierProvider<GetDataSearchByIdFromApi, SearchByIdState>(
        (ref) => GetDataSearchByIdFromApi());

class SearchByIdState {
  final List<Map<String, dynamic>> categoryDateByIdList;
  final bool isLoading;

  SearchByIdState({
    required this.categoryDateByIdList,
    required this.isLoading,
  });

  // Create a default state
  factory SearchByIdState.initial() {
    return SearchByIdState(categoryDateByIdList: [], isLoading: false);
  }
}

class GetDataSearchByIdFromApi extends StateNotifier<SearchByIdState> {
  dynamic? productId;

  GetDataSearchByIdFromApi() : super(SearchByIdState.initial());

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

  void getCategoryById({required productId}) {
    // Update state to indicate loading
    state = SearchByIdState(
      categoryDateByIdList: [],
      isLoading: true,
    );

    DioHelperOneSystem.getData(
            url:
                'http://37.34.242.173:9292/TheOneAPI/api/Product/GetProductById?ProductId=${productId}')
        .then((value) {
      print('Success Get Data Category By Id.....${productId}');
      print(value.data);
      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      // Update state with the retrieved data
      state = SearchByIdState(
        categoryDateByIdList: (json.decode(decryptedText) as List<dynamic>)
            .map((item) => item as Map<String, dynamic>)
            .toList(),
        isLoading: false,
      );
    }).catchError((error) {
      print('is Error Search Date By Id List == $error');
      print('Search 000000000000000000000000000000000000000000000000000000');

      // Update state to indicate an error
      state = SearchByIdState(
        categoryDateByIdList: [],
        isLoading: false,
      );
    });
  }
}
