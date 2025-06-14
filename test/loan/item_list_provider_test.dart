import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/repositories/item_repository.dart';

class MockItemRepository extends Mock implements ItemRepository {}

void main() {
  group('ItemListNotifier', () {
    late ItemRepository itemRepository;
    late ItemListNotifier itemListNotifier;

    setUp(() {
      itemRepository = MockItemRepository();
      itemListNotifier = ItemListNotifier(itemrepository: itemRepository);
    });

    test('loadItemList should return data when successful', () async {
      const loanerId = '123';
      final items = [
        Item.empty().copyWith(id: '1', name: 'item1'),
        Item.empty().copyWith(id: '2', name: 'item2'),
      ];
      when(
        () => itemRepository.getItemList(loanerId),
      ).thenAnswer((_) async => items);

      final result = await itemListNotifier.loadItemList(loanerId);

      expect(
        result.when(
          data: (d) => d,
          error: (e, s) => throw e,
          loading: () => throw Exception('loading'),
        ),
        items,
      );
    });

    test('addItem should return true when successful', () async {
      const loanerId = '123';
      final items = [
        Item.empty().copyWith(id: '1', name: 'item1'),
        Item.empty().copyWith(id: '2', name: 'item2'),
      ];
      final item = Item.empty().copyWith(id: '1', name: 'item1');
      when(
        () => itemRepository.createItem(loanerId, item),
      ).thenAnswer((_) async => item);
      itemListNotifier.state = AsyncValue.data(items);

      final result = await itemListNotifier.addItem(item, loanerId);

      expect(result, true);
    });

    test('updateItem should return true when successful', () async {
      const loanerId = '123';
      final items = [
        Item.empty().copyWith(id: '1', name: 'item1'),
        Item.empty().copyWith(id: '2', name: 'item2'),
      ];
      final item = Item.empty().copyWith(id: '1', name: 'item1');
      when(
        () => itemRepository.updateItem(loanerId, item),
      ).thenAnswer((_) async => true);
      itemListNotifier.state = AsyncValue.data(items);

      final result = await itemListNotifier.updateItem(item, loanerId);

      expect(result, true);
    });

    test('deleteItem should return true when successful', () async {
      const loanerId = '123';
      final items = [
        Item.empty().copyWith(id: '1', name: 'item1'),
        Item.empty().copyWith(id: '2', name: 'item2'),
      ];
      final item = Item.empty().copyWith(id: '1', name: 'item1');
      when(
        () => itemRepository.deleteItem(loanerId, item.id),
      ).thenAnswer((_) async => true);
      itemListNotifier.state = AsyncValue.data(items);

      final result = await itemListNotifier.deleteItem(item, loanerId);

      expect(result, true);
    });

    test('copy should return a copy of the current state', () async {
      final items = [
        Item.empty().copyWith(id: '1', name: 'item1'),
        Item.empty().copyWith(id: '2', name: 'item2'),
      ];
      itemListNotifier.state = AsyncValue.data(items);

      final result = await itemListNotifier.copy();

      expect(
        result.when(
          data: (d) => d,
          error: (e, s) => throw e,
          loading: () => throw Exception('loading'),
        ),
        items,
      );
    });

    test('copy should return a copy of the current state when error', () async {
      final error = Exception('error');
      itemListNotifier.state = AsyncValue.error(error, StackTrace.empty);

      final result = await itemListNotifier.copy();

      expect(result.error, error);
    });

    test(
      'copy should return a copy of the current state when loading',
      () async {
        itemListNotifier.state = const AsyncValue.loading();

        final result = await itemListNotifier.copy();

        expect(result.isLoading, true);
      },
    );
  });
}
