import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay/pay.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/apple/apple_pay_request_source.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/apple/item_payment_request.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/apple/payment_config_helper.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/payment_error_file.dart';
import 'dart:convert';

/// The widget that shows the Apple Pay button.
class ApplePayWidget extends StatefulWidget {
   ApplePayWidget(
      {super.key,
      required this.onPaymentResult,
      this.buttonType = ApplePayButtonType.inStore,
      this.buttonStyle = ApplePayButtonStyle.black});
      

  final PaymentConfigHelper config = PaymentConfigHelper(amount:100, description: 'gggggg', );
  final Function onPaymentResult;
  final ApplePayButtonType buttonType;
  final ApplePayButtonStyle buttonStyle;
  final MethodChannel channel =
      const MethodChannel('flutter.moyasar.com/apple_pay');

  @override
  State<ApplePayWidget> createState() => _ApplePayState();
}

class _ApplePayState extends State<ApplePayWidget> {
  bool isApplePayAvailable = true;
  final String applePayButtonViewNativeId =
      "flutter.moyasar.com/apple_pay/button";

  @override
  void initState() {
    widget.channel.invokeMethod<bool>("isApplePayAvailable", {
      "supportedNetworks": widget.config.supportedNetworks
    }).then((isApplePayAvailableCheckFlag) {
      if (isApplePayAvailableCheckFlag != null &&
          !isApplePayAvailableCheckFlag) {
        // Done like this to not cause a useless rebuild.
        setState(() {
          isApplePayAvailable = isApplePayAvailableCheckFlag;
        });
      }
    }).catchError(
      (error) {
        debugPrint("Apple Pay availability check failed: $error");
      },
    );

    super.initState();
  }

  void onApplePayError() {
    widget.onPaymentResult(PaymentCanceledError());
  }

  void onApplePayResult(paymentResult) async {
    final token = paymentResult['token'];

    if (((token ?? '') == '')) {
      widget.onPaymentResult(UnprocessableTokenError());
      return;
    }

    final source =
        ApplePayPaymentRequestSource(token, widget.config.applePay!.manual);
    final paymentRequest = PaymentRequest(widget.config, source);

    // final result = await MoyasarService.pay(
    //     apiKey: widget.config.publishableApiKey,
    //     paymentRequest: paymentRequest);
  //result
    widget.onPaymentResult();
  }

  String createConfigString() {
    return '''{
        "provider": "apple_pay",
        "data": {
          "merchantIdentifier": "${widget.config.applePay?.merchantId}",
          "displayName": "${widget.config.applePay?.label}",
          "merchantCapabilities": ${jsonEncode(widget.config.applePay?.merchantCapabilities)},
          "supportedCountries": ${jsonEncode(widget.config.applePay?.supportedCountries)},
          "supportedNetworks": ${jsonEncode(widget.config.supportedNetworks)},
          "countryCode": "KW",
          "currencyCode": "KW"
        }
    }''';
  }

  String createCustomNativeConfig() {
    return jsonEncode({
      "merchantIdentifier": "${widget.config.applePay?.merchantId}",
      "paymentLabel": "${widget.config.applePay?.label}",
      "merchantCapabilities": widget.config.applePay?.merchantCapabilities,
      "supportedCountries": widget.config.applePay?.supportedCountries,
      "supportedNetworks": widget.config.supportedNetworks,
      "countryCode": "SA",
      "currencyCode": "SAR",
      "paymentAmount": (widget.config.amount / 100).toStringAsFixed(2)
    });
  }

  @override
  Widget build(BuildContext context) {
    // For now, We will only use the native Apple Pay button when we are sure the user can't use Apple Pay.
    return isApplePayAvailable
        ? ApplePayButton(
            paymentConfiguration:
                PaymentConfiguration.fromJsonString(createConfigString()),
            paymentItems: [
              PaymentItem(
                label: widget.config.applePay!.label,
                amount: (widget.config.amount / 100).toStringAsFixed(2),
              )
            ],
            type: widget.buttonType,
            style: widget.buttonStyle,
            onPaymentResult: onApplePayResult,
            width: MediaQuery.of(context).size.width,
            height: 40,
            onError: (_) {
              onApplePayError();
            },
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width,
              height: 40,
            ),
            child: UiKitView(
              viewType: applePayButtonViewNativeId,
              creationParamsCodec: const StandardMessageCodec(),
              creationParams: createCustomNativeConfig(),
              onPlatformViewCreated: (_) {
                widget.channel.setMethodCallHandler((call) async {
                  if (call.method == 'onApplePayResult') {
                    onApplePayResult(call.arguments);
                  } else if (call.method == 'onApplePayError') {
                    onApplePayError();
                  }
                });
              },
            ),
          );
  }
}