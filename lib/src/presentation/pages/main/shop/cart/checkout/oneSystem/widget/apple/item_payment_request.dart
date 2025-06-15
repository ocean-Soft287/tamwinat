import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/apple/payment_config_helper.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/apple/payment_request_resource.dart';

/// Required data to setup a payment.
///
/// Use only when you need to customize the UI.
class PaymentRequest {
  late int amount;
  late String currency;
  String? description;
  Map<String, dynamic>? metadata;
  late PaymentRequestSource source;
  String? givenID;
  String callbackUrl = PaymentConfigHelper.callbackUrl;

  PaymentRequest(
      PaymentConfigHelper config, PaymentRequestSource paymentRequestSource) {
    amount = config.amount;
    currency = config.currency;
    description = config.description;
    metadata = config.metadata;
    source = paymentRequestSource;
    givenID = config.givenID;
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'source': source.toJson(),
        'currency': currency,
        'description': description,
        'metadata': metadata,
        'callback_url': callbackUrl,
        if (givenID != null) 'given_id': givenID,
      };
}