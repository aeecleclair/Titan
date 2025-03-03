import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/loan/adapters/item.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;
import 'package:myecl/tools/builders/empty_models.dart';

class MockItemRepository extends Mock implements Openapi {}

void main() {
  group('ItemListNotifier', () {
    late MockItemRepository mockRepository;
    late ItemListNotifier provider;
    final items = [
      EmptyModels.empty<Item>().copyWith(id: '1'),
      EmptyModels.empty<Item>().copyWith(id: '2'),
    ];
    final newItem = EmptyModels.empty<Item>().copyWith(id: '3');
    final updatedItem = items.first.copyWith(name: 'Updated Item');

    setUp(() {
      mockRepository = MockItemRepository();
      provider = ItemListNotifier(itemRepository: mockRepository);
    });

    test('loadItemList returns expected data', () async {
      when(
        () => mockRepository.loansLoanersLoanerIdItemsGet(
          loanerId: any(named: 'loanerId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          items,
        ),
      );

      final result = await provider.loadItemList('123');

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        items,
      );
    });

    test('loadItemList handles error', () async {
      when(
        () => mockRepository.loansLoanersLoanerIdItemsGet(
          loanerId: any(named: 'loanerId'),
        ),
      ).thenThrow(Exception('Failed to load items'));

      final result = await provider.loadItemList('123');

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });

    test('addItem adds an item to the list', () async {
      when(
        () => mockRepository.loansLoanersLoanerIdItemsGet(
          loanerId: any(named: 'loanerId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          items,
        ),
      );
      when(
        () => mockRepository.loansLoanersLoanerIdItemsPost(
          loanerId: any(named: 'loanerId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          newItem,
        ),
      );

      await provider.loadItemList('123');
      final result = await provider.addItem(newItem.toItemBase(), '123');

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [...items, newItem],
      );
    });

    test('addItem handles error', () async {
      when(
        () => mockRepository.loansLoanersLoanerIdItemsPost(
          loanerId: any(named: 'loanerId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to add item'));

      final result = await provider.addItem(newItem.toItemBase(), '123');

      expect(result, false);
    });

    test('updateItem updates an item in the list', () async {
      when(
        () => mockRepository.loansLoanersLoanerIdItemsGet(
          loanerId: any(named: 'loanerId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          items,
        ),
      );
      when(
        () => mockRepository.loansLoanersLoanerIdItemsItemIdPatch(
          loanerId: any(named: 'loanerId'),
          itemId: any(named: 'itemId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          updatedItem,
        ),
      );

      await provider.loadItemList('123');
      final result = await provider.updateItem(updatedItem, '123');

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [updatedItem, ...items.skip(1)],
      );
    });

    test('updateItem handles error', () async {
      when(
        () => mockRepository.loansLoanersLoanerIdItemsItemIdPatch(
          loanerId: any(named: 'loanerId'),
          itemId: any(named: 'itemId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update item'));

      final result = await provider.updateItem(updatedItem, '123');

      expect(result, false);
    });

    test('deleteItem removes an item from the list', () async {
      when(
        () => mockRepository.loansLoanersLoanerIdItemsGet(
          loanerId: any(named: 'loanerId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          items,
        ),
      );
      when(
        () => mockRepository.loansLoanersLoanerIdItemsItemIdDelete(
          loanerId: any(named: 'loanerId'),
          itemId: any(named: 'itemId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      await provider.loadItemList('123');
      final result = await provider.deleteItem(items.first.id, '123');

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        items.skip(1).toList(),
      );
    });

    test('deleteItem handles error', () async {
      when(
        () => mockRepository.loansLoanersLoanerIdItemsItemIdDelete(
          loanerId: any(named: 'loanerId'),
          itemId: items.first.id,
        ),
      ).thenThrow(Exception('Failed to delete item'));

      final result = await provider.deleteItem(items.first.id, '123');

      expect(result, false);
    });

    test('filterItems filters items based on query', () async {
      provider.state = AsyncValue.data(items);

      final result = await provider.filterItems('1');

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [items.first],
      );
    });

    test('copy returns a copy of the current state', () async {
      provider.state = AsyncValue.data(items);

      final result = await provider.copy();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        items,
      );
    });
  });
}
