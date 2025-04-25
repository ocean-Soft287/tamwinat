

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sundaymart/src/presentation/pages/main/pickup/One%20System/riverpodOneSystem/cubit/category_all_Cubit.dart';
import 'package:sundaymart/src/presentation/pages/main/pickup/One%20System/riverpodOneSystem/cubit/category_all_state.dart';


import '../../../../theme/app_colors.dart';


// class GetUserDataOneSystem extends StatelessWidget {
//    GetUserDataOneSystem({super.key});
//
//   // dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
//   //   final keyObj = encrypt.Key.fromUtf8(privateKey); // 32 chars
//   //   final ivObj = encrypt.IV.fromUtf8(publicKey); // 16 chars
//   //   final encrypter = encrypt.Encrypter(encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));
//   //
//   //   try {
//   //     final decrypted = encrypter.decrypt(encrypt.Encrypted.fromBase64(encryptedText), iv: ivObj);
//   //     return decrypted;
//   //   } catch (e) {
//   //     print("Error decrypting data: $e");
//   //     return 'Error....................';
//   //   }
//   // }
//   // UserDataModel?userDataModel;
//   // List<UserDataModel> userAll=[];
//   // void getUserData(){
//   //   DioHelperOneSystem.getData(url:'api/Users')
//   //       .then((value){
//   //     print('11111111111111111111111111111111111111111111111111111');
//   //     print('Success');
//   //     print(value.data);
//   //     print('11111111111111111111111111111111111111111111111111111');
//   //     final encryptedText = value.data;
//   //     final privateKey = 'c104780a25b4f80c037445dd1f6947e1'; // استبدل بالمفتاح الخاص بك
//   //     final publicKey = 'e0c9de1b2de26fe2'; // استبدل بالـ IV الخاص بك
//   //
//   //     final decryptedText = decrypt(encryptedText, privateKey, publicKey);
//   //
//   //
//   //  print(decryptedText.runtimeType);
//   //     List<Map<String, dynamic>> dataList =
//   //     (json.decode(decryptedText) as List<dynamic>)
//   //         .map((item) => item as Map<String, dynamic>)
//   //         .toList();
//   //
//   //     // طباعة القائمة
//   //     print(dataList.runtimeType);
//   //     dataList.forEach((element) {
//   //       userAll.add(UserDataModel.fromJson(element));
//   //
//   //     });
//   //
//   //
//   // //  print('Decrypted Text Gamal 101020200000000: $decryptedText');
//   //       print('2222222222222222222222222222222222222222');
//   //   }).catchError((error){
//   //     print('000000000000000000000000000000000000000000000000000000');
//   //     print('is Error == $error');
//   //     print('000000000000000000000000000000000000000000000000000000');
//   //   });
//   // }
//   //
//   //  void getCatgoryDataByID(){
//   //    DioHelperOneSystem.getData(url:'api/Product/GetProductById?ProductId=10')
//   //        .then((value){
//   //      print('11111111111111111111111111111111111111111111111111111');
//   //      print('Success');
//   //      print(value.data);
//   //      print('11111111111111111111111111111111111111111111111111111');
//   //      final encryptedText = value.data;
//   //      final privateKey = 'c104780a25b4f80c037445dd1f6947e1'; // استبدل بالمفتاح الخاص بك
//   //      final publicKey = 'e0c9de1b2de26fe2'; // استبدل بالـ IV الخاص بك
//   //
//   //      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
//   //
//   //
//   //      print(decryptedText.runtimeType);
//   //
//   //      List<Map<String, dynamic>> dataCategoryByIDList =
//   //      (json.decode(decryptedText) as List<dynamic>)
//   //          .map((item) => item as Map<String, dynamic>)
//   //          .toList();
//   //
//   //    print(dataCategoryByIDList[0]["ColorArName"]);
//   //    print(dataCategoryByIDList[0]["BarCode"]);
//   //
//   //
//   //
//   //       print('Decrypted Text Gamal 101020200000000: $decryptedText');
//   //      print('2222222222222222222222222222222222222222');
//   //    }).catchError((error){
//   //      print('000000000000000000000000000000000000000000000000000000');
//   //      print('is Error == $error');
//   //      print('000000000000000000000000000000000000000000000000000000');
//   //    });
//   //  }
//   //
//   //  void getCatgoryAll(){
//   //    DioHelperOneSystem.getData(url:'api/Product/GetAllProducts?pageNumber=1&pageSize=20')
//   //        .then((value){
//   //      print('11111111111111111111111111111111111111111111111111111');
//   //      print('Success');
//   //      print(value.data);
//   //      print('11111111111111111111111111111111111111111111111111111');
//   //      final encryptedText = value.data;
//   //      final privateKey = 'c104780a25b4f80c037445dd1f6947e1'; // استبدل بالمفتاح الخاص بك
//   //      final publicKey = 'e0c9de1b2de26fe2'; // استبدل بالـ IV الخاص بك
//   //
//   //      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
//   //
//   //
//   //      print(decryptedText.runtimeType);
//   //
//   //      List<Map<String, dynamic>> dataCategoryAllList =
//   //      (json.decode(decryptedText) as List<dynamic>)
//   //          .map((item) => item as Map<String, dynamic>)
//   //          .toList();
//   //
//   //      print(dataCategoryAllList[0]["ColorArName"]);
//   //      print(dataCategoryAllList[0]["BarCode"]);
//   //
//   //
//   //
//   //      print('Decrypted Text Gamal 101020200000000: $decryptedText');
//   //      print('222222222222222222222222222222222333333333333333332222222');
//   //    }).catchError((error){
//   //      print('000000000000000000000000000000000000000000000000000000');
//   //      print('is Error == $error');
//   //      print('000000000000000000000000000000000000000000000000000000');
//   //    });
//   //  }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CategoryAllCubit()..getCatgoryAll(),
//       child: BlocConsumer<CategoryAllCubit, CategoryAllCubitState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return
//
//
//                 Scaffold(
//               appBar: AppBar(
//                 backgroundColor: Colors.white,
//                 title: const Text('ِAll Category',style: TextStyle(color: Colors.black87)),
//                 elevation: 0.0,
//                 actions: [
//                  Padding(
//                    padding: const EdgeInsets.all(20.0),
//                    child: Text('All',style: TextStyle(color: Colors.green),),
//                  )
//                 ],
//               ),
//               body:
//               ConditionalBuilder(
//                 condition: BlocProvider.of<CategoryAllCubit>(context).dataCategoryAllList.length >= 0,
//                 builder: (context) =>
//                     Padding(
//                 padding: REdgeInsets.symmetric(horizontal: 16.0),
//                 child:
//                 GridView.builder(
//                   itemCount: BlocProvider.of<CategoryAllCubit>(context).dataCategoryAllList.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 1.5,
//                     crossAxisSpacing: 2,
//                     mainAxisSpacing: 5,
//                   ),
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: [
//                         Container(
//                           padding: REdgeInsets.symmetric(vertical: 24),
//                           child: InkWell(
//                             onTap: () {},
//                             child: Row(
//                               children: [
//
//
//                                 14.horizontalSpace,
//                                 Expanded(
//                                   child: Column(
//
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//
//                                       Text(
//                                         '${BlocProvider.of<CategoryAllCubit>(context).dataCategoryAllList[index]["ProductEnName"]}',
//                                         style: GoogleFonts.inter(
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 14.sp,
//                                           color: AppColors.iconAndTextColor(),
//                                           letterSpacing: -0.4,
//                                         ),
//                                       ),
//                                       4.verticalSpace,
//                                       Text(
//                                         '${BlocProvider.of<CategoryAllCubit>(context).dataCategoryAllList[index]["CategoryEnName"]}',
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: GoogleFonts.inter(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 12.sp,
//                                           color: AppColors.secondaryIconTextColor(),
//                                           letterSpacing: -0.4,
//                                         ),
//                                       ),
//
//
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//
//                       ],
//                     );
//                   },
//                 ),
//               ),
//                   fallback: (context) => Text('???????????????????????????'),
//
//
//             ),
//
//           );
//         },
//       ),
//     );
//   }
//
// }
