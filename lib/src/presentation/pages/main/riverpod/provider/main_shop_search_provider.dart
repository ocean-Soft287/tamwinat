import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependency_manager.dart';
import '../notifier/main_shop_search_notifier.dart';
import '../state/main_shop_search_state.dart';

final mainShopSearchProvider =
    StateNotifierProvider<MainShopSearchNotifier, MainShopSearchState>(
  (ref) => MainShopSearchNotifier(shopsRepository),
);
