import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/delivery_times_notifier.dart';
import '../state/delivery_times_state.dart';

final deliveryTimesProvider =
    StateNotifierProvider<DeliveryTimesNotifier, DeliveryTimesState>(
  (ref) => DeliveryTimesNotifier(),
);
