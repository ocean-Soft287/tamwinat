import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/di/dependency_manager.dart';
import '../notifier/checkout_deliveries_notifier.dart';
import '../state/checkout_deliveries_state.dart';

final checkoutDeliveriesProvider =
    StateNotifierProvider<CheckoutDeliveriesNotifier, CheckoutDeliveriesState>(
  (ref) => CheckoutDeliveriesNotifier(shopsRepository),
);
