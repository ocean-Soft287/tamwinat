import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/shop_category_products_notifier.dart';
import '../state/shop_category_products_state.dart';

final shopCategoryProductsProvider = StateNotifierProvider<
    ShopCategoryProductsNotifier, ShopCategoryProductsState>(
  (ref) => ShopCategoryProductsNotifier(productsRepository, cartRepository),
);
