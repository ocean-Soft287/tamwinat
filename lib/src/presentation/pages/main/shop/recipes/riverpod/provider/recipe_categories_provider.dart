import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/recipe_categories_notifier.dart';
import '../state/recipe_categories_state.dart';

final recipeCategoriesProvider =
    StateNotifierProvider<RecipeCategoriesNotifier, RecipeCategoriesState>(
  (ref) => RecipeCategoriesNotifier(recipesRepository),
);
