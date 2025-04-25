import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/shop_banners_notifier.dart';
import '../state/shop_banners_state.dart';

final shopBannersProvider =
    StateNotifierProvider<ShopBannersNotifier, ShopBannersState>(
  (ref) => ShopBannersNotifier(shopsRepository),
);
