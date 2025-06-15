import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/apple/payment_request_resource.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/apple/payment_type_helper.dart';

/// Required data to setup an Apple Pay payment.
///
/// Use only when you need to customize the UI.
class ApplePayPaymentRequestSource implements PaymentRequestSource {
  @override
  PaymentTypeHelper type = PaymentTypeHelper.applepay;

  late String token;

  late String manual;

  ApplePayPaymentRequestSource(this.token, bool manualPayment) {
    manual = manualPayment ? 'true' : 'false';
  }
  @override
  Map<String, dynamic> toJson() =>
      {'type': type.name, 'token': token, 'manual': manual};
}
