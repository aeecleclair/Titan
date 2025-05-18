import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/vote/adapters/list.dart';
import 'package:myecl/vote/providers/list_list_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;

class MockListRepository extends Mock implements Openapi {}

void main() {
  group('ListListNotifier', () {
    late MockListRepository mockRepository;
    late ListListNotifier provider;
    final lists = [
      EmptyModels.empty<ListReturn>().copyWith(id: '1', type: ListType.pipo),
      EmptyModels.empty<ListReturn>().copyWith(id: '2', type: ListType.serio),
    ];
    final newList = EmptyModels.empty<ListReturn>().copyWith(id: '3');
    final updatedList = lists.first.copyWith(name: 'Updated List');

    setUp(() {
      mockRepository = MockListRepository();
      provider = ListListNotifier(listRepository: mockRepository);
    });

    test('loadListList returns expected data', () async {
      when(() => mockRepository.campaignListsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          lists,
        ),
      );

      final result = await provider.loadListList();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        lists,
      );
    });

    test('loadListList handles error', () async {
      when(() => mockRepository.campaignListsGet())
          .thenThrow(Exception('Failed to load lists'));

      final result = await provider.loadListList();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        null,
      );
    });

    test('addList adds a list to the list', () async {
      when(() => mockRepository.campaignListsPost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          newList,
        ),
      );

      provider.state = AsyncValue.data([...lists]);
      final result = await provider.addList(newList.toListBase());

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [...lists, newList],
      );
    });

    test('addList handles error', () async {
      when(() => mockRepository.campaignListsPost(body: any(named: 'body')))
          .thenThrow(Exception('Failed to add list'));

      provider.state = AsyncValue.data([...lists]);
      final result = await provider.addList(newList.toListBase());

      expect(result, false);
    });

    test('updateList updates a list in the list', () async {
      when(
        () => mockRepository.campaignListsListIdPatch(
          listId: any(named: 'listId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          updatedList,
        ),
      );

      provider.state = AsyncValue.data([...lists]);
      final result = await provider.updateList(updatedList);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [updatedList, ...lists.skip(1)],
      );
    });

    test('updateList handles error', () async {
      when(
        () => mockRepository.campaignListsListIdPatch(
          listId: any(named: 'listId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update list'));

      provider.state = AsyncValue.data([...lists]);
      final result = await provider.updateList(updatedList);

      expect(result, false);
    });

    test('deleteList removes a list from the list', () async {
      when(
        () => mockRepository.campaignListsListIdDelete(
          listId: any(named: 'listId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      provider.state = AsyncValue.data([...lists]);
      final result = await provider.deleteList(lists.first.id);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        lists.skip(1).toList(),
      );
    });

    test('deleteList handles error', () async {
      when(
        () => mockRepository.campaignListsListIdDelete(listId: lists.first.id),
      ).thenThrow(Exception('Failed to delete list'));

      provider.state = AsyncValue.data([...lists]);
      final result = await provider.deleteList(lists.first.id);

      expect(result, false);
    });

    test('copy returns a copy of the current state', () async {
      provider.state = AsyncValue.data([...lists]);

      final result = await provider.copy();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        lists,
      );
    });

    test('shuffle shuffles the lists', () {
      provider.state = AsyncValue.data([...lists]);

      provider.shuffle();

      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        equals(lists),
      );
    });
  });
}
