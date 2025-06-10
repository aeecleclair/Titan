import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/providers/page_controller_provider.dart';

void main() {
  group('AmapPageControllerNotifier', () {
    test('initial state', () {
      final notifier = AmapPageControllerNotifier();
      expect(notifier.state.viewportFraction, 0.9);
      expect(notifier.state.initialPage, 0);
    });

    test('can change state', () {
      final notifier = AmapPageControllerNotifier();
      final newController = PageController(
        viewportFraction: 0.8,
        initialPage: 1,
      );
      notifier.state = newController;
      expect(notifier.state, newController);
    });
  });

  group('amapPageControllerProvider', () {
    test('provides AmapPageControllerNotifier', () {
      final container = ProviderContainer();
      final controller = container.read(amapPageControllerProvider);
      expect(controller, isA<PageController>());
    });

    test('can read and update state', () {
      final container = ProviderContainer();
      final controllerNotifier = container.read(
        amapPageControllerProvider.notifier,
      );
      final newController = PageController(
        viewportFraction: 0.8,
        initialPage: 1,
      );
      controllerNotifier.state = newController;
      expect(container.read(amapPageControllerProvider), newController);
    });
  });
}
