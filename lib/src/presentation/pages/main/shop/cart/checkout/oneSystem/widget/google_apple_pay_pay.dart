import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/google_apple_pay_config.dart';

// ignore: must_be_immutable
class GoogleApplePayPay extends StatelessWidget {
final List<PaymentItem> paymentItems;
  final String totalAmount;

  final void Function(Object?)? onError;
  final Function(Map<String, dynamic>)? onPaymentResult;
 


   GoogleApplePayPay({super.key,
   required this.onError,
   required this.onPaymentResult,
   required this.paymentItems,
  required this.totalAmount,
    
    });

  String os = Platform.operatingSystem;

  @override
  Widget build(BuildContext context) {
    return 
    Platform.isIOS
        ?
        
         ApplePayButton(
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

         )
: GooglePayButton(
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
