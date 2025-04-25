import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/checkout_notifier.dart';
import '../state/checkout_state.dart';

final checkoutProvider =
    StateNotifierProvider.autoDispose<CheckoutNotifier, CheckoutState>(
  (ref) => CheckoutNotifier(),
);
