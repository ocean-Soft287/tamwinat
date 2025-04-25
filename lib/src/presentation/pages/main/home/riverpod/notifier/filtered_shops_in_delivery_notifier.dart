import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../state/filtered_shops_in_delivery_state.dart';

class FilteredShopsInDeliveryNotifier
    extends StateNotifier<FilteredShopsInDeliveryState> {

  FilteredShopsInDeliveryNotifier()
      : super(const FilteredShopsInDeliveryState());

  Future<void> fetchFilteredShops({
    int? groupId,
    VoidCallback? checkYourNetwork,
  }) async {
    if (!state.hasMoreShops) {
      return;
    }
    // final connected = await AppConnectivity.connectivity();
    // if (connected) {
    //   if (_filteredPage == 0) {
    //     state = state.copyWith(isFilteredShopsLoading: true);
    //     final response = await _shopsRepository.getFilteredShops(
    //       page: ++_filteredPage,
    //       groupId: groupId,
    //       deliveryType: ShopDeliveryType.delivery,
    //     );
    //     response.when(
    //       success: (data) {
    //         state = state.copyWith(
    //           isFilteredShopsLoading: false,
    //           filteredShops: data.data ?? [],
    //           hasMoreShops: (data.data ?? []).length >= 10,
    //         );
    //       },
    //       failure: (failure) {
    //         _filteredPage--;
    //         state = state.copyWith(
    //           isFilteredShopsLoading: false,
    //           hasMoreShops: false,
    //         );
    //         debugPrint('==> get shops failure: $failure');
    //       },
    //     );
    //   } else {
    //     state = state.copyWith(isMoreShopsLoading: true);
    //     final response = await _shopsRepository.getFilteredShops(
    //       page: ++_filteredPage,
    //       groupId: groupId,
    //       deliveryType: ShopDeliveryType.delivery,
    //     );
    //     response.when(
    //       success: (data) {
    //         final List<ShopData> newList = List.from(state.filteredShops);
    //         newList.addAll(data.data ?? []);
    //         state = state.copyWith(
    //           isMoreShopsLoading: false,
    //           filteredShops: newList,
    //           hasMoreShops: (data.data ?? []).length >= 10,
    //         );
    //       },
    //       failure: (failure) {
    //         _filteredPage--;
    //         state = state.copyWith(isMoreShopsLoading: false);
    //         debugPrint('==> get shops failure: $failure');
    //       },
    //     );
    //   }
    // } else {
    //   checkYourNetwork?.call();
    // }
  }

  // Future<void> updateFilteredShops(BuildContext context, {int? groupId}) async {
  //   _filteredPage = 0;
  //   state = state.copyWith(hasMoreShops: true);
  //   fetchFilteredShops(
  //     groupId: groupId,
  //     checkYourNetwork: () {
  //       AppHelpers.showCheckFlash(
  //         context,
  //         AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
  //       );
  //     },
  //   );
  // }
}
