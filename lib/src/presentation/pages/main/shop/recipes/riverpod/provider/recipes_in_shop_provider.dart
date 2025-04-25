import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/recipes_in_shop_notifier.dart';
import '../../../recipes/riverpod/state/recipes_in_shop_state.dart';

final recipesInShopProvider =
    StateNotifierProvider<RecipesInShopNotifier, RecipesInShopState>(
  (ref) => RecipesInShopNotifier(recipesRepository),
);
