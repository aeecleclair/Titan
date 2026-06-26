import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmapPageControllerNotifier extends Notifier<PageController> {
  @override
  PageController build() {
    return PageController(viewportFraction: 0.9, initialPage: 0);
  }
}

final amapPageControllerProvider =
    NotifierProvider<AmapPageControllerNotifier, PageController>(
      AmapPageControllerNotifier.new,
    );
