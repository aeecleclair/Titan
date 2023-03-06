import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/providers/main_page_index_provider.dart';

final sessionListPageControllerProvider =
    StateNotifierProvider<SessionListPageControllerNotifier, PageController>(
  (ref) {
    final mainPageIndex = ref.watch(mainPageIndexProvider);
    return SessionListPageControllerNotifier(mainPageIndex);
  },
);

class SessionListPageControllerNotifier extends StateNotifier<PageController> {
  SessionListPageControllerNotifier(int i)
      : super(PageController(
          viewportFraction: 0.8,
          initialPage: i,
        ));
}
