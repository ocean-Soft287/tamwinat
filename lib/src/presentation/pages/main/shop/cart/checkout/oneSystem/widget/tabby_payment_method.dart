// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sundaymart/src/presentation/pages/main/drawer/tamwnate_pro/manager/get_subscribtions_riverpod.dart';
// import 'package:sundaymart/src/presentation/pages/main/drawer/wallet_poinets/manager/wallet_poinets_reiverpod.dart';
// import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
// import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/checkout_riverpod.dart';
// import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/payment_page_success.dart';
// import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

// Future<void> tabby_payment_method(


//  {
//    required OrderItemFun orderItemFun,required var titleNotes,
//   required TextEditingController discountValueControllerCheckOutOnSystem,
//   required int deliveryId,
//  required int selectedOption,
//  required int selectAddress,
// required  int? selectedCardIndex,required
// GlobalKey<FormState> formKey,
//  required GetDataAddressFromApi listAddressUser
//  ,required GetSubscriptionProviderApi getSubscriptionDelivery
//  ,required ListItemOrderImage listItemOrderImage
//  ,required WalletPoints walletPoints
//  ,required String todayDate,
//  required String uniqueReferenceId,
//  required String selectedTime,
//  required String todayName,
//  required dynamic DiscountPercent ,
//  required num totalPrice,
//  required num discountValue,
//  required BuildContext context,
//  required List<Map<String, dynamic>> newmyList,
//  required bool checkTimeNotFound,
//  required num FinalPrice,
//  required String ValueselectedDistrict,
//  required String regionName,
//  required String placeId,
//  required String customerAdressMap,
//  required String nameControllerCheckOutOnSystem,
//    required String BlockNumberControllerCheckOutOnSystem,
//             required String StreetControllerCheckOutOnSystem,
//             required String HouseControllerCheckOutOnSystem,
//              required String gada,
//               required String floorControllerCheckOutOnSystem,
//              required String apartmentControllerCheckOutOnSystem,
//         required String emailControllerCheckOutOnSystem,

//  required String mobileNumberControllerCheckOutOnSystem,
//  required dynamic deleveryValue,
//  required String userPhone,
  
 
//  }) async {
//      if (formKey.currentState!.validate()) {
//       final mockPayload = Payment(
//         amount: (FinalPrice == 0.0)
//             ? (totalPrice >= 20
//                     ? totalPrice +
//                         0.0 // إذا كان totalPrice أكبر من أو يساوي 20، لا تضف رسوم توصيل
//                     : (totalPrice +
//                         ((userPhone == null)
//                             ?deleveryValue
//                             : double.parse((getSubscriptionDelivery
//                                     .subscriptionList
//                                     .isEmpty)
//                                 ? '0.000'
//                                 : (getSubscriptionDelivery.subscriptionList[0]
//                                             [
//                                             'IsSubscribe'] ==
//                                         true)
//                                     ? '0.000'
//                                     : deleveryValue ??
//                                         '1.00'))))
//                 .toStringAsFixed(3)
//             : FinalPrice.toStringAsFixed(3),
//         currency: Currency.kwd,
//         buyer: Buyer(
//           email: (userPhone != null)
//               ? listAddressUser
//                       .dataAddressList[
//                   selectAddress]["Email"]
//               :emailControllerCheckOutOnSystem,
//           phone: (userPhone != null)
//               ? listAddressUser
//                           .dataAddressList[
//                       selectAddress]
//                   ["CustomerPhone"]
//               :mobileNumberControllerCheckOutOnSystem,
//           name: (userPhone != null)
//               ? listAddressUser
//                       .dataAddressList[
//                   selectAddress]["ArabicName"]
//               :nameControllerCheckOutOnSystem,
//           dob: '1990-01-01',
//         ),
//         buyerHistory: BuyerHistory(
//           loyaltyLevel: 0,
//           registeredSince:
//               '2019-08-24T14:15:22Z',
//           wishlistCount: 0,
//         ),
//         shippingAddress:
//             const ShippingAddress(
//           city: 'string',
//           address: 'string',
//           zip: 'string',
//         ),
//         order: Order(
//             referenceId: uniqueReferenceId,
//             items: [
//               OrderItem(
//                 title: 'Jersey',
//                 description: 'Jersey',
//                 quantity: 1,
//                 unitPrice: '10.00',
//                 referenceId: 'uuid',
//                 productUrl:
//                     'http://example.com',
//                 category: 'clothes',
//               )
//             ]),
//         orderHistory: [
//           OrderHistoryItem(
//             purchasedAt:
//                 '2019-08-24T14:15:22Z',
//             amount: (FinalPrice == 0.0)
//                 ? (totalPrice >= 20
//                         ? totalPrice +
//                             0.0 // إذا كان totalPrice أكبر من أو يساوي 20، لا تضف رسوم توصيل
//                         : (totalPrice +
//                             ((userPhone ==
//                                     null)
//                                 ?deleveryValue
//                                 : double.parse((getSubscriptionDelivery
//                                         .subscriptionList
//                                         .isEmpty)
//                                     ? '0.000'
//                                     : (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] ==
//                                             true)
//                                         ? '0.000'
//                                         : deleveryValue ??
//                                             '1.00'))))
//                     .toStringAsFixed(3)
//                 : FinalPrice.toStringAsFixed(
//                     3),
//             paymentMethod:
//                 OrderHistoryItemPaymentMethod
//                     .card,
//             status:
//                 OrderHistoryItemStatus.newOne,
//           )
//         ],
//       );
    
//       try {
//         TabbySDK().setup(withApiKey: 'pk_test_0190c5f9-bbe2-1538-785c-c1b3a45f801b');
//    TabbySession?     session = await TabbySDK()
//             .createSession(
//                 TabbyCheckoutPayload(
//           merchantCode: 'Tmwenat appkwt',
//           lang: Lang.en,
//           payment: mockPayload,
//         ));
      
//           if (session != null &&
//               session!.availableProducts
//                       .installments !=
//                   null) {
//             TabbyWebView.showWebView(
//               context: context,
//               webUrl: session!
//                   .availableProducts
//                   .installments!
//                   .webUrl,
//               onResult:
//                   (WebViewResult resultCode) {
//                 print(
//                     'Result Code: ${resultCode.name}');
    
//                 if (resultCode.name ==
//                     'authorized') {
//                   (userPhone != null)
//                       ? orderItemFun.orderItemFu(
//                           DistriictName: listAddressUser.dataAddressList[selectAddress]["DistrictName"],
//                           context: context,
//                           OrderDate: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
//                           CustomerAddress: listAddressUser.dataAddressList[selectAddress]["CustomerAddress"],
//                           regionName: listAddressUser.dataAddressList[selectAddress]["RegionName"],
//                           CustomerPhone: listAddressUser.dataAddressList[selectAddress]["CustomerPhone"],
//                           CustomerName: listAddressUser.dataAddressList[selectAddress]["ArabicName"],
//                           Block: listAddressUser.dataAddressList[selectAddress]["Block"],
//                           Street: listAddressUser.dataAddressList[selectAddress]["StreetName"],
//                           House: listAddressUser.dataAddressList[selectAddress]["HouseNo"],
//                           DiscountCode: discountValueControllerCheckOutOnSystem.text,
//                           Gada: listAddressUser.dataAddressList[selectAddress]["Gada"],
//                           Floor: listAddressUser.dataAddressList[selectAddress]["Floor"],
//                           Apartment: listAddressUser.dataAddressList[selectAddress]["Apartment"],
//                           Email: listAddressUser.dataAddressList[selectAddress]["Email"],
//                           DeliveryID: deliveryId,
//                           Details: titleNotes,
//                           DeliveryDate: todayDate,
//                           DeliveryDay: todayName,
//                           OrderTime: selectedTime,
//                           TotalValue: totalPrice,
//                           Additions: (totalPrice >= 20)
//                               ? 0.0
//                               : ((userPhone == null)
//                                   ? deleveryValue
//                                   : (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
//                                       ? 0.000
//                                       : deleveryValue ?? 1),
//                           Discount: discountValue,
//                           FinalValue: (FinalPrice == 0.0)
//                               ? (totalPrice >= 20
//                                   ? totalPrice + 0.0 // إذا كان totalPrice أكبر من أو يساوي 20، لا تضف رسوم توصيل
//                                   : (totalPrice +
//                                       double.parse((getSubscriptionDelivery.subscriptionList.isNotEmpty && getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
//                                               ? '0.000' // إذا كان هناك اشتراك، رسوم التوصيل صفر
//                                               : deleveryValue ?? '1.00' // إذا لم يكن هناك اشتراك، استخدم قيمة رسوم التوصيل الافتراضية
//                                           )))
//                               : FinalPrice, // إذا كانت قيمة FinalPrice ليست صفرًا، استخدمها كما هي
    
//                           DiscountCardValue: 0,
//                           PayID: 2,
//                           OnlineStoreId: -1,
//                           orderList: newmyList,
//                           Image: listItemOrderImage.orderListImage,
//                           discountPointsValue: walletPoints.walletPointsList[0]['PointsValue'])
//                       : orderItemFun.orderItemFu(
//                           DistriictName: ValueselectedDistrict,
//                           regionName: regionName,
//                           context: context,
//                           OrderDate: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
//                           CustomerPhone: mobileNumberControllerCheckOutOnSystem,
//                           CustomerName: nameControllerCheckOutOnSystem,
//                           customerMapAdress: customerAdressMap,
//                           placeId: placeId,
//                           Block: BlockNumberControllerCheckOutOnSystem,
//                           Street: StreetControllerCheckOutOnSystem,
//                           House: HouseControllerCheckOutOnSystem,
//                           Gada: gada,
//                           Floor: floorControllerCheckOutOnSystem,
//                           Apartment: apartmentControllerCheckOutOnSystem,
//                           Email: emailControllerCheckOutOnSystem,
//                           DeliveryID: deliveryId,
//                           DiscountCode: discountValueControllerCheckOutOnSystem.text,
//                           Details: titleNotes,
//                           DeliveryDate: todayDate,
//                           DeliveryDay: todayName,
//                           OrderTime: selectedTime,
//                           TotalValue: totalPrice,
//                           Additions: (totalPrice >= 20)
//                               ? 0.0
//                               : ((userPhone == null)
//                                   ? deleveryValue
//                                   : (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
//                                       ? 0.000
//                                       : deleveryValue ?? 1),
//                           Discount: (discountValue == 0.0) ? DiscountPercent : discountValue,
//                           FinalValue: (FinalPrice == 0.0)
//                               ? (totalPrice >= 20
//                                   ? totalPrice + 0.0 // إذا كان totalPrice أكبر من أو يساوي 20، لا تضف رسوم توصيل
//                                   : (totalPrice + deleveryValue))
//                               : FinalPrice, // إذا كانت قيمة FinalPrice ليست صفرًا، استخدمها كما هي
    
//                           DiscountCardValue: 0,
//                           PayID: 2,
//                           OnlineStoreId: -1,
//                           orderList: newmyList,
//                           Image: listItemOrderImage.orderListImage,
//                           CustomerAddress: customerAdressMap // UPDATED HERE
//                           );
//                 } else if (resultCode.name ==
//                         'rejected' ||
//                     resultCode.name ==
//                         'expired' ||
//                     resultCode.name ==
//                         'close') {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           PaymentErrorPage(),
//                     ),
//                   );
//                   // هنا يمكنك عرض رسالة خطأ أو اتخاذ إجراء آخر مثل إعادة المحاولة
//                 } else {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           PaymentErrorPage(),
//                     ),
//                   );
//                 }
//               },
//             );
//           } else {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     PaymentErrorPage(),
//               ),
//             );
//             print(
//                 'Session not initialized or no web URL found');
//           }
        
//       } catch (e) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 PaymentErrorPage(),
//           ),
//         );
//         print('Error creating session: $e');
//       }
//     }
                                    
//   }
///
   // tabby_payment_method(
                                  //   DiscountPercent: widget.DiscountPercent,
                                  //   uniqueReferenceId:uniqueReferenceId ,
                                  //   orderItemFun: orderItemFun,
                                  //    userPhone: UserPhone,
                                  //     titleNotes:widget. titleNotes, discountValueControllerCheckOutOnSystem:
                                  //      discountValueControllerCheckOutOnSystem,
                                  //       deliveryId: DeliveryId,
                                  //        selectedOption: selectedOption,
                                  //         selectAddress: selectAddress
                                  //         , selectedCardIndex: selectedCardIndex, formKey: _formKey, 
                                  //          listAddressUser: listAddressUser, getSubscriptionDelivery: getSubscriptionDelivery,
                                  //           listItemOrderImage: listItemOrderImage, walletPoints: walletPoints,
                                  //            todayDate: todayDate, selectedTime: selectedTime, todayName: todayName,
                                  //             totalPrice: totalPrice, discountValue:widget. discountValue,
                                  //              context: context,
                                  //               newmyList:widget. newmyList, 
                                  //               checkTimeNotFound: checkTimeNotFound,
                                            
                                  //               FinalPrice: FinalPrice,
                                  //                 ValueselectedDistrict:widget. ValueselectedDistrict ?? "", regionName:widget. regionName,
                                  //                  placeId:  widget.placeId!, customerAdressMap:
                                  //                 widget. customerAdressMap!, nameControllerCheckOutOnSystem:
                                  //                  widget.  nameControllerCheckOutOnSystem, 
                                  //                    BlockNumberControllerCheckOutOnSystem:widget. BlockNumberControllerCheckOutOnSystem, 
                                  //                    StreetControllerCheckOutOnSystem:widget. StreetControllerCheckOutOnSystem,
                                  //                     HouseControllerCheckOutOnSystem:widget. HouseControllerCheckOutOnSystem, 
                                  //                     gada:widget. gada, floorControllerCheckOutOnSystem:widget. floorControllerCheckOutOnSystem,
                                  //                      apartmentControllerCheckOutOnSystem:widget. apartmentControllerCheckOutOnSystem,
                                  //                       emailControllerCheckOutOnSystem:widget. emailControllerCheckOutOnSystem, mobileNumberControllerCheckOutOnSystem:widget. mobileNumberControllerCheckOutOnSystem,
                                  //                         deleveryValue: deleveryValue,
                                                          
                                                           
                                  //                          );
                               