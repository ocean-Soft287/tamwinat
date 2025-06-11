import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pay/pay.dart';
import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/tamwnate_pro/manager/get_subscribtions_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/wallet_poinets/manager/wallet_poinets_reiverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/checkout_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/payment_page_success.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/google_apple_pay_config.dart';

class GoogleApplePayPay extends StatelessWidget {
   final List<PaymentItem> paymentItems;
  final String totalAmount;
  // final OrderItemFun orderItemFun;
  // final String titleNotes;
  // final TextEditingController discountValueControllerCheckOutOnSystem;
  // final int deliveryId;
  // final int selectedOption;
  // final int selectAddress;
  // final int? selectedCardIndex;
  // final GlobalKey<FormState> formKey;
  // final dynamic deleveryValue;
  // final String userPhone;
  // final dynamic DiscountPercent;
  final void Function(Object?)? onError;
  final Function(Map<String, dynamic>)? onPaymentResult;
  // Address & User Info
  // final GetDataAddressFromApi listAddressUser;
  // final String ValueselectedDistrict;
  // final String regionName;
  // final String placeId;
  // final String customerAdressMap;
  // final String nameControllerCheckOutOnSystem;
  // final String BlockNumberControllerCheckOutOnSystem;
  // final String StreetControllerCheckOutOnSystem;
  // final String HouseControllerCheckOutOnSystem;
  // final String gada;
  // final String floorControllerCheckOutOnSystem;
  // final String apartmentControllerCheckOutOnSystem;
  // final String emailControllerCheckOutOnSystem;
  // final String mobileNumberControllerCheckOutOnSystem;

  // Order Info
  // final GetSubscriptionProviderApi getSubscriptionDelivery;
  // final ListItemOrderImage listItemOrderImage;
  // final WalletPoints walletPoints;
  // final String todayDate;
  // final String selectedTime;
  // final String todayName;
  // final num totalPrice;
  // final num discountValue;
  // final BuildContext context;
  // final List<Map<String, dynamic>> newmyList;
  // final bool checkTimeNotFound;
  // final num FinalPrice;

   GoogleApplePayPay({super.key,
   required this.onError,
   required this.onPaymentResult,
   required this.paymentItems,
    // required this.orderItemFun,
    // required this.titleNotes,
    // required this.discountValueControllerCheckOutOnSystem,
    // required this.deliveryId,
    // required this.selectedOption,
    // required this.selectAddress,
    // required this.selectedCardIndex,
    // required this.formKey,
    // required this.deleveryValue,
    // required this.userPhone,
    // required this.listAddressUser,
    // required this.ValueselectedDistrict,
    // required this.regionName,
    // required this.placeId,
    // required this.customerAdressMap,
    // required this.nameControllerCheckOutOnSystem,
    // required this.BlockNumberControllerCheckOutOnSystem,
    // required this.StreetControllerCheckOutOnSystem,
    // required this.HouseControllerCheckOutOnSystem,
    // required this.gada,
    // required this.floorControllerCheckOutOnSystem,
    // required this.apartmentControllerCheckOutOnSystem,
    // required this.emailControllerCheckOutOnSystem,
    // required this.mobileNumberControllerCheckOutOnSystem,
    // required this.getSubscriptionDelivery,
    // required this.listItemOrderImage,
    // required this.walletPoints,
    // required this.todayDate,
    // required this.selectedTime,
    // required this.todayName,
    // required this.totalPrice,
    // required this.discountValue,
    // required this.context,
    // required this.newmyList,
    // required this.checkTimeNotFound,
    // required this.FinalPrice,
    required this.totalAmount,
    //  this.DiscountPercent,
    
    });

  String os = Platform.operatingSystem;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? ApplePayButton(
            paymentConfiguration:
                PaymentConfiguration.fromJsonString(defaultApplePay),
            paymentItems: paymentItems,
            style: ApplePayButtonStyle.black,
            width: double.infinity,
            height: 50,
            type: ApplePayButtonType.buy,
            margin: const EdgeInsets.only(top: 15.0),
            onError: onError,
            onPaymentResult: onPaymentResult,

            // (error)
            //  =>  Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) =>
            //               PaymentErrorPage(),
            //         ),
            //       ) ,
           
           
    //         (result) {
                 
    //  try {
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
    //                   titleNotes ?? '',
    //               DeliveryDate: todayDate,
    //               DeliveryDay: todayName,
    //               OrderTime: selectedTime,
    //               TotalValue: totalPrice,
    //               Additions: (totalPrice >=
    //                       20)
    //                   ? 0.0
    //                   : double.tryParse((getSubscriptionDelivery
    //                                   .subscriptionList
    //                                   .isNotEmpty &&
    //                               getSubscriptionDelivery.subscriptionList[0]
    //                                       [
    //                                       'IsSubscribe'] ==
    //                                   true)
    //                           ? '0.000'
    //                           : deleveryValue ??
    //                               '1.00') ??
    //                       1.00,
    //               Discount:
    //                   discountValue,
    //               FinalValue: (FinalPrice ==
    //                       0.0)
    //                   ? (totalPrice >= 20
    //                       ? totalPrice
    //                       : totalPrice +
    //                           (double.tryParse((getSubscriptionDelivery.subscriptionList.isNotEmpty &&
    //                                       getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] ==
    //                                           true)
    //                                   ? '0.000'
    //                                   : deleveryValue ??
    //                                       '1.00') ??
    //                               1.00))
    //                   : FinalPrice,
    //               DiscountCardValue: 0,
    //               PayID: 2,
    //               OnlineStoreId: -1,
    //               orderList: newmyList,
    //               Image: listItemOrderImage
    //                   .orderListImage,
    //               discountPointsValue: walletPoints
    //                       .walletPointsList
    //                       .isNotEmpty
    //                   ? walletPoints
    //                           .walletPointsList[
    //                       0]['PointsValue']
    //                   : 0,
    //             )
    //           : orderItemFun.orderItemFu(
    //               DistriictName: ValueselectedDistrict,
    //               regionName:
    //                   regionName,
    //               context: context,
    //               OrderDate:
    //                   DateFormat('yyyy-MM-dd')
    //                       .format(DateTime.now())
    //                       .toString(),
    //               CustomerPhone: mobileNumberControllerCheckOutOnSystem,
    //               CustomerName: nameControllerCheckOutOnSystem,
    //               customerMapAdress: customerAdressMap,
    //               placeId: placeId,
    //               Block: BlockNumberControllerCheckOutOnSystem,
    //               Street: StreetControllerCheckOutOnSystem,
    //               House: HouseControllerCheckOutOnSystem,
    //               Gada: gada,
    //               Floor: floorControllerCheckOutOnSystem,
    //               Apartment: apartmentControllerCheckOutOnSystem,
    //               Email: emailControllerCheckOutOnSystem,
    //               DeliveryID: deliveryId,
    //               DiscountCode:
    //                   discountValueControllerCheckOutOnSystem
    //                       .text,
    //               Details: titleNotes,
    //               DeliveryDate: todayDate,
    //               DeliveryDay: todayName,
    //               OrderTime: selectedTime,
    //               TotalValue: totalPrice,
    //               Additions: (totalPrice >=
    //                       20)
    //                   ? 0.0
    //                   : ((UserPhone == null)
    //                       ? DeliveryValue
    //                       : (getSubscriptionDelivery
    //                                       .subscriptionList[0]
    //                                   [
    //                                   'IsSubscribe'] ==
    //                               true)
    //                           ? 0.0
    //                           : double.tryParse(
    //                                   deleveryValue ??
    //                                       '1.00') ??
    //                               1.00),
    //               Discount:
    //                   (discountValue ==
    //                           0.0)
    //                       ? DiscountPercent
    //                       : discountValue,
    //               FinalValue: (FinalPrice ==
    //                       0.0)
    //                   ? (totalPrice >= 20
    //                       ? totalPrice
    //                       : (totalPrice +
    //                          DeliveryValue))
    //                   : FinalPrice,
    //               DiscountCardValue: 0,
    //               PayID: 2,
    //               OnlineStoreId: -1,
    //               orderList: newmyList,
    //               Image: listItemOrderImage
    //                   .orderListImage,
    //               CustomerAddress: customerAdressMap,
    //             );
    //     } catch (e, stackTrace) {
    //       log("⚠️ حدث خطأ: $e");
    //       log("🔍 تتبع الخطأ: $stackTrace");
    //       print(
    //           '********************************************************');
    //       log('Error inside then block: \$e');
    //       print(
    //           '*********************************************///');
    
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) =>
    //               PaymentSuccessButOrderFailedScreen(
    //             sendOrderAgain: () {
    //               (UserPhone != null)
    //                   ? orderItemFun
    //                       .orderItemFu(
    //                       context: context,
    //                       OrderDate: DateFormat(
    //                               'yyyy-MM-dd')
    //                           .format(
    //                               DateTime.now())
    //                           .toString(),
    //                       CustomerAddress: listAddressUser
    //                                   .dataAddressList[
    //                               selectAddress]
    //                           [
    //                           "CustomerAddress"],
    //                       regionName: listAddressUser
    //                                   .dataAddressList[
    //                               selectAddress]
    //                           ["RegionName"],
    //                       CustomerPhone: listAddressUser
    //                                   .dataAddressList[
    //                               selectAddress]
    //                           [
    //                           "CustomerPhone"],
    //                       CustomerName: listAddressUser
    //                                   .dataAddressList[
    //                               selectAddress]
    //                           ["ArabicName"],
    //                       Email: listAddressUser
    //                                   .dataAddressList[
    //                               selectAddress]
    //                           ["Email"],
    //                       DeliveryID:
    //                           deliveryId,
    //                       DiscountCode:
    //                           discountValueControllerCheckOutOnSystem
    //                               .text,
    //                       Details: titleNotes ??
    //                           '',
    //                       DeliveryDate:
    //                           todayDate,
    //                       DeliveryDay:
    //                           todayName,
    //                       OrderTime:
    //                           selectedTime,
    //                       TotalValue:
    //                           totalPrice,
    //                       Additions: (totalPrice >=
    //                               20)
    //                           ? 0.0
    //                           : double.tryParse((getSubscriptionDelivery.subscriptionList.isNotEmpty &&
    //                                       getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] ==
    //                                           true)
    //                                   ? '0.000'
    //                                   : deleveryValue ??
    //                                       '1.00') ??
    //                               1.00,
    //                       Discount: discountValue,
    //                       FinalValue: (FinalPrice ==
    //                               0.0)
    //                           ? (totalPrice >=
    //                                   20
    //                               ? totalPrice
    //                               : totalPrice +
    //                                   (double.tryParse((getSubscriptionDelivery.subscriptionList.isNotEmpty && getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
    //                                           ? '0.000'
    //                                           : deleveryValue ?? '1.00') ??
    //                                       1.00))
    //                           : FinalPrice,
    //                       DiscountCardValue:
    //                           0,
    //                       PayID: 2,
    //                       OnlineStoreId: -1,
    //                       orderList: newmyList,
    //                       Image: listItemOrderImage
    //                           .orderListImage,
    //                       discountPointsValue: walletPoints
    //                               .walletPointsList
    //                               .isNotEmpty
    //                           ? walletPoints
    //                                   .walletPointsList[0]
    //                               [
    //                               'PointsValue']
    //                           : 0,
    //                     )
    //                   : orderItemFun
    //                       .orderItemFu(
    //                       DistriictName: ValueselectedDistrict,
    //                       regionName: regionName,
    //                       context: context,
    //                       OrderDate: DateFormat(
    //                               'yyyy-MM-dd')
    //                           .format(
    //                               DateTime.now())
    //                           .toString(),
    //                       CustomerPhone: mobileNumberControllerCheckOutOnSystem,
    //                       CustomerName: nameControllerCheckOutOnSystem,
    //                       customerMapAdress:
    //                           customerAdressMap,
    //                       placeId:
    //                           placeId,
    //                       Block: BlockNumberControllerCheckOutOnSystem,
    //                       Street: StreetControllerCheckOutOnSystem,
    //                       House: HouseControllerCheckOutOnSystem,
    //                       Gada: gada,
    //                       Floor: floorControllerCheckOutOnSystem,
    //                       Apartment: apartmentControllerCheckOutOnSystem,
    //                       Email: emailControllerCheckOutOnSystem,
    //                       DeliveryID:
    //                           deliveryId,
    //                       DiscountCode:
    //                           discountValueControllerCheckOutOnSystem
    //                               .text,
    //                       Details: titleNotes,
    //                       DeliveryDate:
    //                           todayDate,
    //                       DeliveryDay:
    //                           todayName,
    //                       OrderTime:
    //                           selectedTime,
    //                       TotalValue:
    //                           totalPrice,
    //                       Additions: (totalPrice >=
    //                               20)
    //                           ? 0.0
    //                           : ((UserPhone ==
    //                                   null)
    //                               ? DeliveryValue
    //                               : (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] ==
    //                                       true)
    //                                   ? 0.0
    //                                   : double.tryParse(deleveryValue ??
    //                                           '1.00') ??
    //                                       1.00),
    //                       Discount: (discountValue ==
    //                               0.0)
    //                           ?DiscountPercent
    //                           : discountValue,
    //                       FinalValue: (FinalPrice ==
    //                               0.0)
    //                           ? (totalPrice >=
    //                                   20
    //                               ? totalPrice
    //                               : (totalPrice +
    //                                 DeliveryValue))
    //                           : FinalPrice,
    //                       DiscountCardValue:
    //                           0,
    //                       PayID: 2,
    //                       OnlineStoreId: -1,
    //                       orderList: newmyList,
    //                       Image: listItemOrderImage
    //                           .orderListImage,
    //                       CustomerAddress: customerAdressMap,
    //                     );
    //             },
    //           ),
    //         ),
        
    //       );
    //     }
    //   })
        )

       :         
                
 GooglePayButton(
            paymentConfiguration:
                PaymentConfiguration.fromJsonString(defaultGooglePay),
            paymentItems: paymentItems,
            type: GooglePayButtonType.pay,
            margin: const EdgeInsets.only(top: 15.0),
             onError: onError,
            onPaymentResult: onPaymentResult,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          );}

}
