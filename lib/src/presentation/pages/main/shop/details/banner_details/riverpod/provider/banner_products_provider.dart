import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/di/dependency_manager.dart';
import '../notifier/banner_products_notifier.dart';
import '../state/banner_products_state.dart';

final bannerProductsProvider =
    StateNotifierProvider<BannerProductsNotifier, BannerProductsState>(
  (ref) => BannerProductsNotifier(shopsRepository),
);
