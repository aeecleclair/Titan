import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/loan/providers/end_provider.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('fr');
  });

  group('EndNotifier', () {
    test('setEnd should update state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final endNotifier = container.read(endProvider.notifier);
      endNotifier.setEnd('2022-12-31');
      expect(endNotifier.state, '2022-12-31');
    });

    test('setEndFromSelected should update state based on selected items', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final endNotifier = container.read(endProvider.notifier);
      const start = '01/01/2022';
      final selected = [
        Item.empty().copyWith(suggestedLendingDuration: 7),
        Item.empty().copyWith(suggestedLendingDuration: 14),
        Item.empty().copyWith(suggestedLendingDuration: 21),
      ];
      endNotifier.setEndFromSelected(start, selected, "fr");
      expect(endNotifier.state, '08/01/2022');
    });

    test('resetEnd should reset state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final endNotifier = container.read(endProvider.notifier);
      endNotifier.setEnd('2022-12-31');
      endNotifier.setEnd('');
      expect(endNotifier.state, '');
    });
  });
}
