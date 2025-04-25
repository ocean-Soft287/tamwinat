
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryDataNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  CategoryDataNotifier() : super([]);

  void setData(List<Map<String, dynamic>> newData) {
    state = newData;
  }
}