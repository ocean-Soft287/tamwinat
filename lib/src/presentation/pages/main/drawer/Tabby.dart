import 'package:flutter/material.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import 'package:flutter/material.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TabbySession? session;

  @override
  void initState() {
    super.initState();
    createCheckoutSession();
  }

  Future<void> createCheckoutSession() async {
    final mockPayload = Payment(
      amount: '50',
      currency: Currency.kwd,
      buyer: Buyer(
        email: 'id.card.success@tabby.ai',
        phone: '+96590000001',
        name: 'Yazan Khalid',
        dob: '2019-08-24',
      ),
      buyerHistory: BuyerHistory(
        loyaltyLevel: 0,
        registeredSince: '2019-08-24T14:15:22Z',
        wishlistCount: 0,
      ),
      shippingAddress: const ShippingAddress(
        city: 'string',
        address: 'string',
        zip: 'string',
      ),
      order: Order(referenceId: 'id123', items: [
        OrderItem(
          title: 'Jersey',
          description: 'Jersey',
          quantity: 1,
          unitPrice: '10.00',
          referenceId: 'uuid',
          productUrl: 'http://example.com',
          category: 'clothes',
        )
      ]),
      orderHistory: [
        OrderHistoryItem(
          purchasedAt: '2019-08-24T14:15:22Z',
          amount: '10.00',
          paymentMethod: OrderHistoryItemPaymentMethod.card,
          status: OrderHistoryItemStatus.newOne,
        )
      ],
    );

    try {
      session = await TabbySDK().createSession(TabbyCheckoutPayload(
        merchantCode: 'Tmwenat appkwt',
        lang: Lang.en,
        payment: mockPayload,
      ));
      setState(() {});
    } catch (e) {
      print('Error creating session: $e');
    }
  }

  void openInAppBrowser() {
    if (session != null &&
        session!.availableProducts.installments != null &&
        session!.availableProducts.installments!.webUrl != null) {
      TabbyWebView.showWebView(
        context: context,
        webUrl: session!.availableProducts.installments!.webUrl,
        onResult: (WebViewResult resultCode) {
          print('Result Code: ${resultCode.name}');

          // تحقق من حالة الدفع بناءً على قيمة resultCode
          if (resultCode.name == 'success') {
            print('Payment successful. Proceed to print invoice.');

          } else if (resultCode.name == 'canceled') {
            print('Payment was canceled by the user.');
          } else {
            print('Payment failed or unknown state: ${resultCode.name}');
          }
        },
      );
    } else {
      print('Session not initialized or no web URL found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabby Checkout'),
      ),
      body: session == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          TabbyPresentationSnippet(
            price: '340',
            currency: Currency.kwd,
            lang: Lang.ar,
          ),
          Expanded(
            child: session!.availableProducts.installments != null &&
                session!.availableProducts.installments!.webUrl != null
                ? TabbyWebView(
              webUrl: session!.availableProducts.installments!.webUrl!,
              onResult: (WebViewResult resultCode) {
                print(resultCode.name);
                print('HAAAAAAAAAAAMMMMMMMMMMMMMMMMMM');

              },
            )
                : Center(child: Text('No available products or Web URL not found.')),
          ),
        ],
      ),
    );
  }
}

