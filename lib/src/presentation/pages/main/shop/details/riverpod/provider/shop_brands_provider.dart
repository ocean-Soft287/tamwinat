import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/shop_brands_notifier.dart';
import '../state/shop_brands_state.dart';

final shopBrandsProvider =
    StateNotifierProvider<ShopBrandsNotifier, ShopBrandsState>(
  (ref) => ShopBrandsNotifier(catalogRepository),
);
