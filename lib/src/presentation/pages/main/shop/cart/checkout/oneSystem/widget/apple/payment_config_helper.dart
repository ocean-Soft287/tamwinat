
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/apple/apple_pay_config.dart';

/// Used by Moyasar API along with any of the supported sources.
class PaymentConfigHelper {
  /// Used internally to manage the 3DS step.
  static String callbackUrl = "https://example.com/thanks";

  

  /// The smallest currency unit.
  /// For example, to charge `SAR 257.58` you will have the [amount] as `25758`.
  /// In other words, 10 SAR = 10 * 100 Halalas.
  late int amount;

  /// Must be in ISO 3166-1 alpha-3 country code format.
  /// The default value is "SAR".
  String currency;

  /// Can be any string you want to tag the payment.
  /// For example `Payment for Order #34321`
  String description;

  /// The [metadata] adds searchable key/value pairs to the payment.
  /// For example `{"size": "xl"}`
  Map<String, dynamic>? metadata;

  /// Optional configuration used to set accepted card networks.
  /// Supported Networks: ["amex", "visa", "mada", "masterCard"]
  List<String> supportedNetworks;

  /// The config required to setup Apple Pay.
  ApplePayConfig? applePay;

  /// The config required to extend the Credit Card payment feature.

  /// given_id It is going be the ID of the created payment.
  String? givenID;

  PaymentConfigHelper(
      {
      required this.amount,
      this.currency = 'SAR',
      required this.description,
      this.metadata,
      this.supportedNetworks = const ["amex", "visa", "mada", "masterCard"],
      this.applePay,
      this.givenID})
      : 
        assert(amount > 0, 'Please add a positive amount.'),
        assert(description.isNotEmpty, 'Please add a description.'),
        assert(supportedNetworks.isNotEmpty,
            'At least 1 network must be supported.');
}