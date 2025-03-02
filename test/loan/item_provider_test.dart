import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/item_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

void main() {
  group('ItemNotifier', () {
    late ProviderContainer container;
    late ItemNotifier notifier;
    final item = Item(
      id: '1',
      name: 'Test Item',
      suggestedLendingDuration: 7,
      suggestedCaution: 100,
      totalQuantity: 10,
      loanedQuantity: 0,
      loanerId: '123',
    );

    setUp(() {
      container = ProviderContainer();
      notifier = container.read(itemProvider.notifier);
    });

    test('setItem should update state', () {
      notifier.setItem(item);

      expect(container.read(itemProvider).id, equals('1'));
      expect(container.read(itemProvider).name, equals('Test Item'));
      expect(container.read(itemProvider).suggestedCaution, equals(100));
    });

    test('resetItem should reset state', () {
      notifier.setItem(item);
      notifier.setItem(Item.fromJson({}));

      expect(container.read(itemProvider).id, equals(''));
      expect(container.read(itemProvider).name, equals(''));
      expect(container.read(itemProvider).suggestedCaution, equals(0));
    });
  });
}
