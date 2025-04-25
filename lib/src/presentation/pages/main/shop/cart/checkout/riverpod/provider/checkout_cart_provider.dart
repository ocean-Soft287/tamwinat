import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/di/dependency_manager.dart';
import '../notifier/checkout_cart_notifier.dart';
import '../state/checkout_cart_state.dart';

final checkoutCartProvider =
    StateNotifierProvider<CheckoutCartNotifier, CheckoutCartState>(
  (ref) => CheckoutCartNotifier(cartRepository),
);
