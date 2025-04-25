import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/shop_categories_notifier.dart';
import '../state/shop_categories_state.dart';

final shopCategoriesProvider =
    StateNotifierProvider<ShopCategoriesNotifier, ShopCategoriesState>(
  (ref) => ShopCategoriesNotifier(catalogRepository),
);
