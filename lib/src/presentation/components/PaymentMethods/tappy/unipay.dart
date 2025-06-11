import 'package:flutter/material.dart';
import 'package:sundaymart/src/presentation/components/PaymentMethods/payment_dialog.dart';
import 'package:sundaymart/src/presentation/components/PaymentMethods/tappy/credentails.dart';
import 'package:uni_pay/uni_pay.dart';

class UniPayCheckoutPage extends StatelessWidget {
  final String appName;
  final UniPayLocale locale;
  final UniPayCustomerInfo customerInfo;
  final UniPayOrder orderInfo;
  final Map<String, dynamic> metaData;

  // Callbacks
  final Function(Map<String, dynamic>) onPaymentSuccess;
  final Function(Map<String, dynamic>) onPaymentFailed;

  const UniPayCheckoutPage({
    super.key,
    required this.appName,
    required this.locale,
    required this.customerInfo,
    required this.orderInfo,
    this.metaData = const {},
    required this.onPaymentSuccess,
    required this.onPaymentFailed,
  });

  @override
  Widget build(BuildContext context) {
    return     UniPay(
          context: context,
          uniPayData: UniPayData(
            appName: appName,
            locale: locale,
            customerInfo: customerInfo,
            environment: UniPayEnvironment.development,
            credentials: Credentails.getUniPayCredentials(),
            orderInfo: orderInfo,
            onPaymentSucess: (res) {
              onPaymentSuccess(res.toMap());
              showSuccessDialog(context, res.toMap());
            },
            onPaymentFailed: (res) {
              onPaymentFailed(res.toMap());
              showFailureDialog(context, res.toMap());
            },
            metaData: metaData,
          ),
        );
     
  }


}

//                                 return UniPayCheckoutPage (
//                                   appName: "",
//                                   locale:UniPayLocale.en, 
//                                   orderInfo:  UniPayOrder(
//                                     items: [
//                                       UniPayItem(
//                                         name: widget.titleNotes ?? '',
//                                         id: '1',
//                                         price: 200,
//                                         quantity: 1
//                                     )],
//                                     transactionAmount: TransactionAmount(totalAmount: 200),
//                                     description: "",
//     orderId: 'ORDER-${DateTime.now().millisecondsSinceEpoch}',
//   ),
//                                  onPaymentSuccess: (response) {
//     log("Payment Success: $response");
//     // Navigate to success page or update order status
//   },
//   onPaymentFailed: (error) {
//     log("Payment Failed: $error");
//     // Show error message
//   },
                                 
//                                   metaData:  {
//     'DeliveryDate': todayDate,
//     'DeliveryDay': todayName,
//     'OrderTime': selectedTime,
//     'DiscountCode': discountValueControllerCheckOutOnSystem.text,
//     'Details': widget.titleNotes ?? '',
//     'DeliveryID': DeliveryId,
//     'TotalValue': totalPrice,
//     'Additions': (totalPrice >= 20) ? 0.0 : 1.0,
//     'Discount': widget.discountValue,
//     'orderList': widget.newmyList,
//     'Image': listItemOrderImage.orderListImage,
//     'DiscountPointsValue': walletPoints.walletPointsList.isNotEmpty
//         ? walletPoints.walletPointsList[0]['PointsValue']
//         : 0,
//   },
//                                   customerInfo:  UniPayCustomerInfo(
//                                     address: widget.StreetControllerCheckOutOnSystem.text,
//   fullName: widget.nameControllerCheckOutOnSystem.text,
//   email: widget.emailControllerCheckOutOnSystem.text,
//   phoneNumber: widget.mobileNumberControllerCheckOutOnSystem.text,
// ),
                                
//                                 );
                              