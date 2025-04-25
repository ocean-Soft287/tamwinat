import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/dependency_manager.dart';
import '../notifier/saved_shops_in_delivery_notifier.dart';
import '../state/saved_shops_in_delivery_state.dart';

final savedShopsInDeliveryProvider = StateNotifierProvider<
    SavedShopsInDeliveryNotifier, SavedShopsInDeliveryState>(
  (ref) => SavedShopsInDeliveryNotifier(shopsRepository),
);
