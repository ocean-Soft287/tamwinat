import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/constants/constants.dart';
import '../../../../../../../repository/repository.dart';
import '../state/shop_banners_state.dart';

class ShopBannersNotifier extends StateNotifier<ShopBannersState> {
  final ShopsRepository _shopsRepository;

  ShopBannersNotifier(this._shopsRepository) : super(const ShopBannersState());

  Future<void> fetchShopBanners({int? shopId}) async {
    state = state.copyWith(isLoading: true);
    final response = await _shopsRepository
        .getBannersPaginate(BannerType.banner, shopId: shopId);
    response.when(
      success: (data) {
        state = state.copyWith(isLoading: false, banners: data.data ?? []);
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> get shop banners failure: $failure');
      },
    );
  }
}
