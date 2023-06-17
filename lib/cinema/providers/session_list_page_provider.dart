import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/providers/main_page_index_provider.dart';

final sessionListPageControllerProvider =
    StateNotifierProvider.family<SessionListPageControllerNotifier, PageController, int>(
  (ref, i) {
    return SessionListPageControllerNotifier(i);
  },
);

class SessionListPageControllerNotifier extends StateNotifier<PageController> {
  SessionListPageControllerNotifier(int i)
      : super(PageController(
          viewportFraction: 0.8,
          initialPage: i,
        ));
}
