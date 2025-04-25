import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/cart_notifier.dart';
import '../state/cart_state.dart';

final cartProvider = StateNotifierProvider.autoDispose<CartNotifier, CartState>(
  (ref) => CartNotifier(cartRepository),
);
