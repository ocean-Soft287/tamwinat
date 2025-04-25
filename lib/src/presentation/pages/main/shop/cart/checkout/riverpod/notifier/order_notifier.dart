import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/utils/utils.dart';
import '../../../../../../../../repository/repository.dart';
import '../state/order_state.dart';

class OrderNotifier extends StateNotifier<OrderState> {
  final OrdersRepository _ordersRepository;

  OrderNotifier(this._ordersRepository) : super(const OrderState());

  Future<void> createOrder({
    VoidCallback? checkYourNetwork,
    VoidCallback? orderSuccess,
    int? shopId,
    double? total,
    double? deliveryFee,
    String? coupon,
    int? addressId,
    double? totalDiscount,
    int? deliveryTypeId,
    double? tax,
    String? deliveryDate,
    String? deliveryTime,
    int? cartId,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await _ordersRepository.createOrder(
        shopId: shopId,
        total: total,
        deliveryFee: deliveryFee,
        coupon: (coupon?.isEmpty ?? true) ? null : coupon,
        addressId: addressId,
        totalDiscount: totalDiscount,
        deliveryTypeId: deliveryTypeId,
        tax: tax,
        deliveryDate: deliveryDate,
        deliveryTime: deliveryTime,
        cartId: cartId,
      );
      response.when(
        success: (data) {
          state = state.copyWith(isLoading: false);
          orderSuccess?.call();
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> get cart calculations failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }
}
