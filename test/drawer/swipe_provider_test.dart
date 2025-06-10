import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/drawer/providers/swipe_provider.dart';

class MockTicker extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('SwipeControllerNotifier', () {
    test('SwipeControllerNotifier can close animation controller', () {
      final controller = AnimationController(
        vsync: MockTicker(),
        duration: const Duration(microseconds: 1),
      );
      final swipeController = SwipeControllerNotifier(controller);
      swipeController.close();
      Future.delayed(const Duration(milliseconds: 1), () {
        expect(controller.value, equals(0));
      });
    });

    test('SwipeControllerNotifier can detect drag start from left', () {
      final controller = AnimationController(
        vsync: MockTicker(),
        duration: const Duration(seconds: 1),
      );
      final swipeController = SwipeControllerNotifier(controller);
      final startDetails = DragStartDetails(
        globalPosition: const Offset(50, 0),
      );
      swipeController.onDragStart(startDetails);
      expect(SwipeControllerNotifier.shouldDrag, equals(true));
    });
  });
}
