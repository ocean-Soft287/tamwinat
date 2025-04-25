import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/di/dependency_manager.dart';
import '../notifier/open_cart_notifier.dart';
import '../state/open_cart_state.dart';

final openCartProvider = StateNotifierProvider<OpenCartNotifier, OpenCartState>(
  (ref) => OpenCartNotifier(cartRepository),
);
