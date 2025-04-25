import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/utils/utils.dart';
import '../../../../../../../../models/models.dart';
import '../../../../../../../../repository/repository.dart';
import '../state/checkout_deliveries_state.dart';

class CheckoutDeliveriesNotifier
    extends StateNotifier<CheckoutDeliveriesState> {
  final ShopsRepository _shopsRepository;

  CheckoutDeliveriesNotifier(this._shopsRepository)
      : super(const CheckoutDeliveriesState());

  void setPickupDate(DateTime? date) {
    state = state.copyWith(pickupDate: date);
  }

  void setDeliveryTime(DateTime? date) {
    state = state.copyWith(deliveryTime: date);
  }

  void setDeliveryDate(DateTime? date) {
    state = state.copyWith(deliveryDate: date);
  }

  void setSelectedDeliveryTypeIndex(int index) {
    state = state.copyWith(selectedDeliveryTypeIndex: index);
  }

  void setIsPickup(bool value) {
    state = state.copyWith(isPickup: value);
  }

  Future<void> fetchShopDeliveries({int? shopId}) async {
    if (shopId == null) {
      return;
    }
    state = state.copyWith(isLoading: true);
    final response = await _shopsRepository.getShopDeliveries([shopId]);
    response.when(
      success: (data) {
        final List<ShopData> shops = data.data ?? [];
        ShopData? currentShop;
        for (final shop in shops) {
          if (shop.id == shopId) {
            currentShop = shop;
          }
        }
        final deliveries = currentShop?.deliveries ?? [];
        final List<LocalAddressData> addresses =
            LocalStorage.instance.getLocalAddressesList();
        int addressIndex = 0;
        for (int i = 0; i < addresses.length; i++) {
          if (addresses[i].isDefault ?? false) {
            addressIndex = i;
            break;
          }
        }
        state = state.copyWith(
          isLoading: false,
          shopDeliveries: deliveries,
          isPickup: AppHelpers.getDeliveries(deliveries).isEmpty &&
              AppHelpers.hasPickup(deliveries),
          selectedDeliveryAddressIndex: addressIndex,
          shopData: currentShop,
        );
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> get shop deliveries failure: $failure');
      },
    );
  }
}
