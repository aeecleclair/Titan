import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageControllerProvider =
    StateNotifierProvider<AmapPageControllerNotifier, PageController>(
  (ref) {
    return AmapPageControllerNotifier();
  },
);

class AmapPageControllerNotifier extends StateNotifier<PageController> {
  AmapPageControllerNotifier() : super(PageController());
}
