//   import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sundaymart/main.dart';
// import 'package:sundaymart/src/presentation/pages/main/drawer/tamwnate_pro/manager/get_subscribtions_riverpod.dart';
// import 'package:sundaymart/src/presentation/pages/main/drawer/wallet_poinets/manager/wallet_poinets_reiverpod.dart';
// import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
// import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/checkout_riverpod.dart';

// void onCashSelected(
//   {
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
//  required String selectedTime,
//  required String todayName,
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
//   }) {
   
//        if (formKey.currentState!.validate() &&
//         selectedCardIndex! >= 0) {
//       (UserPhone != null)
//           ? orderItemFun.orderItemFu(
//               context: context,
//               OrderDate:
//                   DateFormat('yyyy-MM-dd')
//                       .format(DateTime.now())
//                       .toString(),
//               CustomerAddress: listAddressUser
//                           .dataAddressList[
//                       selectAddress]
//                   ["CustomerAddress"],
//               regionName: listAddressUser
//                           .dataAddressList[
//                       selectAddress]
//                   ["RegionName"],
//               CustomerPhone: listAddressUser
//                           .dataAddressList[
//                       selectAddress]
//                   ["CustomerPhone"],
//               CustomerName: listAddressUser
//                           .dataAddressList[
//                       selectAddress]
//                   ["ArabicName"],
//               Email: listAddressUser
//                       .dataAddressList[
//                   selectAddress]["Email"],
//               DeliveryID: deliveryId,
//               DiscountCode:
//                   discountValueControllerCheckOutOnSystem
//                       .text,
//               Details:
//                  titleNotes ?? '',
//               DeliveryDate: todayDate,
//               DeliveryDay: todayName,
//               OrderTime: selectedTime,
//               TotalValue: totalPrice,
//               Additions: (totalPrice >= 20)
//                   ? 0.0
//                   : double.parse(
//                       (getSubscriptionDelivery
//                                   .subscriptionList
//                                   .isNotEmpty &&
//                               getSubscriptionDelivery
//                                           .subscriptionList[0]
//                                       [
//                                       'IsSubscribe'] ==
//                                   true)
//                           ? '0.000' // إذا كان هناك اشتراك، رسوم التوصيل ستكون 0
//                           : deleveryValue ??
//                               '1.00' // إذا لم يكن هناك اشتراك، استخدم قيمة deleveryValue أو 5.000 كقيمة افتراضية
//                       ),
//               Discount:discountValue,
//               FinalValue: (FinalPrice == 0.0)
//                   ? (totalPrice >= 20
//                       ? totalPrice + 0.0
//                       : totalPrice +
//                           double.parse(
//                               (getSubscriptionDelivery
//                                           .subscriptionList
//                                           .isNotEmpty &&
//                                       getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] ==
//                                           true)
//                                   ? '0.000' // إذا كان هناك اشتراك، رسوم التوصيل ستكون 0
//                                   : deleveryValue ??
//                                       '1.00' // إذا لم يكن هناك اشتراك، استخدم قيمة deleveryValue أو 5.000 كقيمة افتراضية
//                               ))
//                   : FinalPrice,
//               DiscountCardValue: 0,
//               PayID: selectedOption,
//               OnlineStoreId: -1,
//               orderList:newmyList,
//               Image: listItemOrderImage
//                   .orderListImage,
//               customerMapAdress:
//                   listAddressUser
//                               .dataAddressList[
//                           selectAddress]
//                       ["MapCustomerAddress"],
//               placeId: listAddressUser
//                           .dataAddressList[
//                       selectAddress]
//                   ["MapPlaceID"],
//               discountPointsValue: walletPoints
//                       .walletPointsList
//                       .isNotEmpty
//                   ? walletPoints
//                           .walletPointsList[0]
//                       ['PointsValue']
//                   : 0.0,
//             )
//           : orderItemFun.orderItemFu(
//               DistriictName: 
//                   ValueselectedDistrict,
//               regionName:regionName,
//               context: context,
//               OrderDate:
//                   DateFormat('yyyy-MM-dd')
//                       .format(DateTime.now())
//                       .toString(),
//               CustomerPhone: mobileNumberControllerCheckOutOnSystem,
//               CustomerName: nameControllerCheckOutOnSystem,
//               Block: BlockNumberControllerCheckOutOnSystem,
//               Street: StreetControllerCheckOutOnSystem,
//               House: HouseControllerCheckOutOnSystem,
//               Gada:gada,
//               Floor: floorControllerCheckOutOnSystem,
//               DiscountCode:
//                   discountValueControllerCheckOutOnSystem
//                       .text,
//               Apartment: apartmentControllerCheckOutOnSystem,
//               Email: emailControllerCheckOutOnSystem,
//               DeliveryID: deliveryId,
//               Details:titleNotes,
//               DeliveryDate: todayDate,
//               DeliveryDay: todayName,
//               OrderTime: selectedTime,
//               TotalValue: totalPrice,
//               Additions: (totalPrice >= 20)
//                   ? 0.0
//                   : ((UserPhone == null)
//                       ?DeliveryValue
//                       : (getSubscriptionDelivery
//                                       .subscriptionList[0]
//                                   [
//                                   'IsSubscribe'] ==
//                               true)
//                           ? '0.000'
//                           : deleveryValue ??
//                               1),
//               Discount:discountValue,
//               FinalValue: (FinalPrice == 0.0)
//                   ? (totalPrice >= 20
//                           ? totalPrice +
//                               0.0 // إذا كان totalPrice أكبر من أو يساوي 20، لا تضف رسوم توصيل
//                           : totalPrice +
//                              DeliveryValue // إذا كان totalPrice أقل من 20، أضف رسوم التوصيل
//                       )
//                   : FinalPrice,
//               DiscountCardValue: 0,
//               PayID: selectedOption,
//               OnlineStoreId: -1,
//               orderList:newmyList,
//               Image: listItemOrderImage
//                   .orderListImage,
//               customerMapAdress:
//                  customerAdressMap,
//               placeId:placeId,
//             );
//     } else {

//         checkTimeNotFound = false;
     
//   }
// }




///////
///   //  onCashSelected(orderItemFun: orderItemFun,
                                    //  userPhone: UserPhone,
                                    //   titleNotes:widget. titleNotes, discountValueControllerCheckOutOnSystem:
                                    //    discountValueControllerCheckOutOnSystem,
                                    //     deliveryId: DeliveryId,
                                    //      selectedOption: selectedOption,
                                    //       selectAddress: selectAddress
                                    //       , selectedCardIndex: selectedCardIndex, formKey: _formKey, 
                                    //        listAddressUser: listAddressUser, getSubscriptionDelivery: getSubscriptionDelivery,
                                    //         listItemOrderImage: listItemOrderImage, walletPoints: walletPoints,
                                    //          todayDate: todayDate, selectedTime: selectedTime, todayName: todayName,
                                    //           totalPrice: totalPrice, discountValue:widget. discountValue,
                                    //            context: context,
                                    //             newmyList:widget. newmyList, 
                                    //             checkTimeNotFound: checkTimeNotFound,
                                            
                                    //             FinalPrice: FinalPrice,
                                    //               ValueselectedDistrict:widget. ValueselectedDistrict, regionName:widget. regionName,
                                    //                placeId:  widget.placeId!, customerAdressMap:
                                    //               widget. customerAdressMap!, nameControllerCheckOutOnSystem:
                                    //                widget.  nameControllerCheckOutOnSystem, 
                                    //                  BlockNumberControllerCheckOutOnSystem:widget. BlockNumberControllerCheckOutOnSystem, 
                                    //                  StreetControllerCheckOutOnSystem:widget. StreetControllerCheckOutOnSystem,
                                    //                   HouseControllerCheckOutOnSystem:widget. HouseControllerCheckOutOnSystem, 
                                    //                   gada:widget. gada, floorControllerCheckOutOnSystem:widget. floorControllerCheckOutOnSystem,
                                    //                    apartmentControllerCheckOutOnSystem:widget. apartmentControllerCheckOutOnSystem,
                                    //                     emailControllerCheckOutOnSystem:widget. emailControllerCheckOutOnSystem, mobileNumberControllerCheckOutOnSystem:widget. mobileNumberControllerCheckOutOnSystem,
                                    //                       deleveryValue: deleveryValue,
                                                          
                                                           
                                    //                        );
                                 