import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScrollControllerNotifier extends StateNotifier<ScrollController> {
  ScrollControllerNotifier(super.scrollController);
}

final scrollControllerProvider =
    StateNotifierProvider<ScrollControllerNotifier, ScrollController>((ref) {
      return ScrollControllerNotifier(ScrollController());
    });
