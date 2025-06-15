  import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/apple/payment_type_helper.dart';

abstract class PaymentRequestSource {
  late PaymentTypeHelper type;

  Map<String, dynamic> toJson();
}