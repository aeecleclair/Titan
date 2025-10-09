import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/loan/providers/caution_provider.dart';

void main() {
  group('CautionNotifier', () {
    test(
      'setCaution sets the text and selection of the TextEditingController',
      () {
        final notifier = CautionNotifier();
        final textEditingController = notifier.state;

        notifier.setCaution('Test Caution');

        expect(textEditingController.text, 'Test Caution');
        expect(textEditingController.selection.baseOffset, 12);
        expect(textEditingController.selection.extentOffset, 12);
      },
    );
  });

  group('cautionProvider', () {
    test('cautionProvider returns a CautionNotifier', () {
      final container = ProviderContainer();
      final notifier = container.read(cautionProvider.notifier);

      expect(notifier, isA<CautionNotifier>());
    });

    test('cautionProvider returns a TextEditingController', () {
      final container = ProviderContainer();
      final textEditingController = container.read(cautionProvider);

      expect(textEditingController, isA<TextEditingController>());
    });
  });
}
