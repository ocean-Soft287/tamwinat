import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/main_bottom_notifier.dart';
import '../state/main_bottom_state.dart';

final mainBottomProvider =
    StateNotifierProvider<MainBottomNotifier, MainBottomState>(
  (ref) => MainBottomNotifier(),
);
