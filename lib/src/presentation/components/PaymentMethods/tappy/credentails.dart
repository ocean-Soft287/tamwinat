import 'package:uni_pay/uni_pay.dart';

class Credentails {

static UniPayCredentials getUniPayCredentials() {
  return UniPayCredentials(
    paymentMethods: [
     // UniPayPaymentMethods.card,
      UniPayPaymentMethods.applepay,
     // UniPayPaymentMethods.tamara,
      UniPayPaymentMethods.tabby,
    ],
    // moyasarCredential: MoyasarCredential(
    //   publishableKey: "pk_test_yourPublishableKey",
    //   secretKey: "sk_test_yourSecretKey",
    // ),
   
    // tamaraCredential: TamaraCredential(
    //   token: "Bearer your_tamara_token",
    //   merchantUrl: MerchantUrl(
    //     notification: "https://your-backend.com/tamara_webhook",
    //   ),
    // ),
    applePayMerchantIdentifier: "merchant.com.apptamwe.app",
    tabbyCredential: TabbyCredential(
      psKey: "pk_test_0190c5f9-bbe2-1538-785c-c1b3a45f801b",
      secretKey: "sk_test_0190c5f9-bbe2-1538-785c-c1b4635a85b6",
      merchantCode: "Tmwenat appkwt",
    ),
  );
}
}