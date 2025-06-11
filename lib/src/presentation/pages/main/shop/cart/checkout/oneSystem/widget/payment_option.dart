// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:myfatoorah_flutter/MFApplePayButton.dart';
// import 'package:myfatoorah_flutter/MFGooglePayButton.dart';
// import 'package:sundaymart/src/presentation/components/components.dart';
// import 'package:sundaymart/src/presentation/pages/main/drawer/tamwnate_pro/manager/get_subscribtions_riverpod.dart';
// import 'package:sundaymart/src/presentation/pages/main/drawer/wallet_poinets/manager/wallet_poinets_reiverpod.dart';
// import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
// import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/google_apple_pay.dart';
// import 'package:sundaymart/src/riverpod/gh.dart';

// class PaymentOptionsWidget extends StatelessWidget {
//   final AppModel lang;
//   final GetDataAddressFromApi listAddressUser;
//   final GetSubscriptionProviderApi getSubscriptionDelivery;
//   final WalletPoints walletPoints;
//   final String uniqueReferenceId;
//  final   int selectedOption ;
// final    MFGooglePayButton mfGooglePayButton;
// final MFApplePayButton mfApplePayButton;
//  final Function()?  onCashSelected;
//   final Function()?  onTabbySelected;
//   final Function()?  onOtherPaymentSelected;

//   const PaymentOptionsWidget({
//     super.key,
//     required this.lang,
//     required this.listAddressUser,
//     required this.getSubscriptionDelivery,
//     required this.walletPoints,
//     required this.uniqueReferenceId, required this.selectedOption, required this.mfGooglePayButton, required this.mfApplePayButton, this.onCashSelected, this.onTabbySelected, this.onOtherPaymentSelected,
//   });
// @override
// Widget build(BuildContext context) {
//   return Padding(
//     padding: REdgeInsets.only(left: 16, right: 16, bottom: 36),
//     child: Consumer(
//       builder: (context, ref, child) {
//         if (selectedOption == 26) {
//           return googlePayButton(mfGooglePayButton: mfGooglePayButton);
//         } else if (selectedOption == 24) {
//           return applePayView(mfApplePayButton: mfApplePayButton);
//         } else {
//           if (selectedOption == 0) {
//             return MainConfirmButton(
//               background: Colors.orange,
//               title: (lang.activeLanguage.languageCode == 'ar') ? 'كاش' : "Cash",
//               onTap: onCashSelected,
//             );
//           } else if (selectedOption == 10) {
//             return MainConfirmButton(
//               background: Colors.orange,
//               title: (lang.activeLanguage.languageCode == 'ar') ? 'المتابعه' : "Continue",
//               onTap: onTabbySelected,
//             );
//           } else {
//             return MainConfirmButton(
//               background: Colors.orange,
//               title: (lang.activeLanguage.languageCode == 'ar') ? ' ادفع' : 'Pay',
//               onTap: onOtherPaymentSelected,
//             );
//           }
//         }
//       },
//     ),
//   );
// }
// }