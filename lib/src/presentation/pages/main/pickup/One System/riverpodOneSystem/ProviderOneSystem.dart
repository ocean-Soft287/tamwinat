
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'StateOneSystem.dart';
final categoryDataProvider = StateNotifierProvider<CategoryDataNotifier, List<Map<String, dynamic>>>(
      (ref) => CategoryDataNotifier(),
);