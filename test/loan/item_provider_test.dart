import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/loan/providers/item_provider.dart';

void main() {
  group('ItemNotifier', () {
    test('setItem should update state with given item', () {
      final itemNotifier = ItemNotifier();
      final item = Item.empty().copyWith(name: 'Test Item', caution: 100);

      itemNotifier.setItem(item);

      expect(itemNotifier.state, equals(item));
    });
  });

  group('itemProvider', () {
    test('should return an instance of ItemNotifier', () {
      final container = ProviderContainer();
      final itemNotifier = container.read(itemProvider.notifier);

      expect(itemNotifier, isA<ItemNotifier>());
    });
  });
}
