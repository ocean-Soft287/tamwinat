import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../models/models.dart';
import '../../../../../../../../repository/repository.dart';
import '../state/notifications_state.dart';

class NotificationsNotifier extends StateNotifier<NotificationsState> {
  final CatalogRepository _catalogRepository;
  int _page = 0;

  NotificationsNotifier(this._catalogRepository)
      : super(const NotificationsState());

  Future<void> fetchNotifications() async {
    if (!state.hasMore) {
      return;
    }
    if (_page == 0) {
      state = state.copyWith(isLoading: true);
      final response =
          await _catalogRepository.getBlogs(++_page, 'notification');
      response.when(
        success: (data) {
          state = state.copyWith(
            isLoading: false,
            notifications: data.data ?? [],
            hasMore: (data.data ?? []).length >= 14,
          );
        },
        failure: (failure) {
          _page--;
          state = state.copyWith(isLoading: false, hasMore: false);
          debugPrint('==> get notifications failure: $failure');
        },
      );
    } else {
      state = state.copyWith(isMoreLoading: true);
      final response =
          await _catalogRepository.getBlogs(++_page, 'notification');
      response.when(
        success: (data) {
          final List<BlogData> newList = List.from(state.notifications);
          newList.addAll(data.data ?? []);
          state = state.copyWith(
            isMoreLoading: false,
            notifications: newList,
            hasMore: (data.data ?? []).length >= 14,
          );
        },
        failure: (failure) {
          _page--;
          state = state.copyWith(isMoreLoading: false);
          debugPrint('==> get notifications failure: $failure');
        },
      );
    }
  }

  Future<void> updateNotifications() async {
    _page = 0;
    state = state.copyWith(hasMore: true);
    fetchNotifications();
  }
}
