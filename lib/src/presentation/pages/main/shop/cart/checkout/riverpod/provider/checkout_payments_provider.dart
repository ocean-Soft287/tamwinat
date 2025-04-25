import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/di/dependency_manager.dart';
import '../notifier/checkout_payments_notifier.dart';
import '../state/checkout_payments_state.dart';

final checkoutPaymentsProvider =
    StateNotifierProvider<CheckoutPaymentsNotifier, CheckoutPaymentsState>(
  (ref) => CheckoutPaymentsNotifier(cartRepository),
);
