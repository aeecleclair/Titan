import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionListPageControllerProvider =
    NotifierProvider.family<
      SessionListPageControllerNotifier,
      PageController,
      int
    >(SessionListPageControllerNotifier.new);

class SessionListPageControllerNotifier extends Notifier<PageController> {
  SessionListPageControllerNotifier(this.initialPage);

  final int initialPage;

  @override
  PageController build() {
    return PageController(viewportFraction: 0.8, initialPage: initialPage);
  }
}
