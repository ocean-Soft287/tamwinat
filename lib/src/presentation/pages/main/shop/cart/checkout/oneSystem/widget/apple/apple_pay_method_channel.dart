import 'package:flutter/services.dart';

class ApplePayService {
  static const platform = MethodChannel('apple_pay');

  Future<void> startApplePay({required String merchantId}) async {
    try {
      await platform.invokeMethod('startApplePay', {'merchantId': merchantId});
    } on PlatformException catch (e) {
      print("Failed to show Apple Pay: '${e.message}'.");
    }
  }
}