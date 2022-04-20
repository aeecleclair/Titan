import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Le notifier du controlleur de défilement
class ScrollControllerNotifier extends StateNotifier<ScrollController> {
  ScrollControllerNotifier(ScrollController scrollController)
      : super(scrollController);
}

/// Le provider du controlleur de défilement (on passe un controlleur d'animation en paramètre, d'où le .family et l'AnimationController en plus)
final scrollControllerProvider = StateNotifierProvider<
    ScrollControllerNotifier, ScrollController>((ref) {
  ScrollController _scrollController = ScrollController();
  return ScrollControllerNotifier(_scrollController);
});
