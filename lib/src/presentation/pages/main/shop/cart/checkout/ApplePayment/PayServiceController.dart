import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class PaymentController {
  static final PaymentController _singleton = PaymentController._internal();

  factory PaymentController() {
    return _singleton;
  }

  PaymentController._internal();

  List<ProductDetails> products = [];
  List<PurchaseDetails> purchaseStreampurchaseDetailsList = [];

  Set<String> kIds = {'item1', 'item12'};

  bool isAvailableShare = false;
  bool isLoading = true;

  late StreamSubscription<List<PurchaseDetails>> _subscription;
  //PaymentuiController paymentuiController = Get.find();

  init() async {
    await initialize();
    await streamOnPurchasedItems();
  }

  Future<void> streamOnPurchasedItems() async {
    _subscription = InAppPurchase.instance.purchaseStream.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        for (var item in purchaseDetailsList) {
          handlePurchaseUpdate(item);
        }
        purchaseStreampurchaseDetailsList = purchaseDetailsList;
      },
      onDone: () => _subscription.cancel(),
      onError: (Object error) {
        if (kDebugMode) print(error);
      },
      cancelOnError: true,
    );
  }

  handlePurchaseUpdate(PurchaseDetails item) async {
    switch (item.status) {
      case PurchaseStatus.purchased:
        await updateUserSubscriptionDate(item);
        InAppPurchase.instance.completePurchase(item); // Confirm purchase
        break;
      case PurchaseStatus.pending:
        debugPrint("Pending ${item.productID}");
        //Show loader
        break;
      case PurchaseStatus.error:
        //Show loader
        //    Get.snackbar('خطأ', 'حدث خطأ أثناء معالجة الدفع');
        break;
      case PurchaseStatus.canceled:
        //Show loader
        //Get.snackbar('تم الإلغاء', 'تم إلغاء الدفع');
        break;
      default:
        // Get.snackbar('تم الإلغاء', 'تم إلغاء الدفع');
        break;
    }
  }

  Future<void> initialize() async {
    try {
      final bool isAvailable = await InAppPurchase.instance.isAvailable();
      if (!isAvailable) throw Exception('الدفع غير متاح حالياً');

      if (Platform.isIOS) {
        final iosPlatformAddition = InAppPurchase.instance
            .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
        await iosPlatformAddition.setDelegate(PaymentQueueDelegate());
      }

      final response = await InAppPurchase.instance.queryProductDetails(kIds);
      if (response.notFoundIDs.isNotEmpty) throw Exception('المنتج غير متاح');

      isAvailableShare = isAvailable;
      products = response.productDetails;
      isLoading = false;
    } catch (error) {
      isLoading = false;

      /// Get.snackbar('خطأ', error.toString());
    }
  }

  Future<bool?> purchase(ProductDetails product, Object whatever) async {
    try {
      await _clearPendingPurchases();

      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: product,
        applicationUserName: '..',
      );

      //Show loader
      await InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);

      return true;
    } catch (e) {
      //Todo:handle error message;
      // Get.snackbar('خطأ', e.toString());
      // if (kDebugMode) {
      //   print(e);
      // }
      // paymentuiController.wait(false);
      // Get.back();
      return false;
    }
  }

  updateUserSubscriptionDate(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.productID.isNotEmpty) {
      log("Sucessful Purchase ${purchaseDetails.productID}");
    } else {
      log('No Purchase Found');
      //Show loader
    }
  }

  Future<void> _clearPendingPurchases() async {
    final transactions = await SKPaymentQueueWrapper().transactions();
    for (final transaction in transactions) {
      await SKPaymentQueueWrapper().finishTransaction(transaction);
    }
  }
}

class PaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
    SKPaymentTransactionWrapper transaction,
    SKStorefrontWrapper storefront,
  ) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() => false;
}
