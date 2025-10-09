import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final amapPageControllerProvider =
    StateNotifierProvider<AmapPageControllerNotifier, PageController>((ref) {
      return AmapPageControllerNotifier();
    });

class AmapPageControllerNotifier extends StateNotifier<PageController> {
  AmapPageControllerNotifier()
    : super(PageController(viewportFraction: 0.9, initialPage: 0));
}
