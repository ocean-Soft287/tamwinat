// import 'dart:convert';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../DioOneSystem.dart';
// import 'category_all_state.dart';
//
// import 'package:encrypt/encrypt.dart' as encrypt;
//
//
// class CategoryAllCubit extends Cubit<CategoryAllCubitState> {
//   CategoryAllCubit() : super(InitializeCategoryAllCubit());
//
//   dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
//     final keyObj = encrypt.Key.fromUtf8(privateKey); // 32 chars
//     final ivObj = encrypt.IV.fromUtf8(publicKey); // 16 chars
//     final encrypter = encrypt.Encrypter(
//         encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));
//
//     try {
//       final decrypted = encrypter.decrypt(
//           encrypt.Encrypted.fromBase64(encryptedText), iv: ivObj);
//       return decrypted;
//     } catch (e) {
//       print("Error decrypting data: $e");
//       return 'Error....................';
//     }
//   }
//
//   List<Map<String, dynamic>> dataCategoryAllList=[];
//  void getCatgoryAll(){
//    emit(CategoryAllLoadingState());
//    DioHelperOneSystem.getData(url:'api/Product/GetAllProducts?pageNumber=1&pageSize=20')
//        .then((value){
//      print('11111111111111111111111111111111111111111111111111111');
//      print('Success');
//      print(value.data);
//      print('11111111111111111111111111111111111111111111111111111');
//      final encryptedText = value.data;
//      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
//      final publicKey = 'e0c9de1b2de26fe2';
//
//      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
//
//
//
//
//     dataCategoryAllList =
//      (json.decode(decryptedText) as List<dynamic>)
//          .map((item) => item as Map<String, dynamic>)
//          .toList();
//
//      print(dataCategoryAllList[0]["ColorArName"]);
//      print(dataCategoryAllList[0]["BarCode"]);
//
//     print(dataCategoryAllList[0]);
//     print('00000000000000');
//      print(dataCategoryAllList[1]);
//      print('11111111111111111111');
//      print(dataCategoryAllList[2]);
//
//      emit(CategoryAllSuccessState());
//    }).catchError((error){
//
//      print('is Error == $error');
//      print('000000000000000000000000000000000000000000000000000000');
//      emit(CategoryAllErrorState());
//    });
//  }
//
//
//
// }