import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/vote/class/contender.dart';
import 'package:titan/vote/providers/contender_list_provider.dart';
import 'package:titan/vote/repositories/contender_repository.dart';

class MockContenderRepository extends Mock implements ContenderRepository {}

void main() {
  group('ContenderListNotifier', () {
    late ContenderListNotifier contenderListNotifier;

    setUp(() {
      contenderListNotifier = ContenderListNotifier(
        contenderRepository: MockContenderRepository(),
      );
    });

    test('loadContenderList', () async {
      final contenders = [
        Contender.empty().copyWith(
          id: '1',
          name: 'Contender 1',
          listType: ListType.fake,
        ),
        Contender.empty().copyWith(
          id: '2',
          name: 'Contender 2',
          listType: ListType.serious,
        ),
        Contender.empty().copyWith(
          id: '3',
          name: 'Contender 3',
          listType: ListType.blank,
        ),
      ];
      when(
        () => contenderListNotifier.contenderRepository.getContenders(),
      ).thenAnswer((_) async => contenders);
      await contenderListNotifier.loadContenderList();
      expect(
        contenderListNotifier.state.when(
          data: (contenders) => contenders,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        contenders,
      );
    });

    test('addContender', () async {
      final contenders = [
        Contender.empty().copyWith(
          id: '1',
          name: 'Contender 1',
          listType: ListType.fake,
        ),
        Contender.empty().copyWith(
          id: '2',
          name: 'Contender 2',
          listType: ListType.serious,
        ),
        Contender.empty().copyWith(
          id: '3',
          name: 'Contender 3',
          listType: ListType.blank,
        ),
      ];
      final newContender = Contender.empty().copyWith(
        id: '4',
        name: 'Contender 4',
        listType: ListType.serious,
      );
      when(
        () => contenderListNotifier.contenderRepository.createContender(
          newContender,
        ),
      ).thenAnswer((_) async => newContender);
      contenderListNotifier.state = AsyncValue.data(contenders.sublist(0));
      await contenderListNotifier.addContender(newContender);

      expect(
        contenderListNotifier.state.when(
          data: (contenders) => contenders,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        contenders + [newContender],
      );
    });

    test('updateContender', () async {
      final contenders = [
        Contender.empty().copyWith(
          id: '1',
          name: 'Contender 1',
          listType: ListType.serious,
        ),
        Contender.empty().copyWith(
          id: '2',
          name: 'Contender 2',
          listType: ListType.fake,
        ),
        Contender.empty().copyWith(
          id: '3',
          name: 'Contender 3',
          listType: ListType.blank,
        ),
      ];
      final updatedContender = Contender.empty().copyWith(
        id: '2',
        name: 'Contender 2 updated',
        listType: ListType.fake,
      );
      when(
        () => contenderListNotifier.contenderRepository.updateContender(
          updatedContender,
        ),
      ).thenAnswer((_) async => true);
      contenderListNotifier.state = AsyncValue.data(contenders);
      await contenderListNotifier.updateContender(updatedContender);

      expect(
        contenderListNotifier.state.when(
          data: (contenders) => contenders,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        contenders
            .map(
              (contender) => contender.id == updatedContender.id
                  ? updatedContender
                  : contender,
            )
            .toList(),
      );
    });

    test('deleteContender', () async {
      final contenders = [
        Contender.empty().copyWith(
          id: '1',
          name: 'Contender 1',
          listType: ListType.serious,
        ),
        Contender.empty().copyWith(
          id: '2',
          name: 'Contender 2',
          listType: ListType.fake,
        ),
        Contender.empty().copyWith(
          id: '3',
          name: 'Contender 3',
          listType: ListType.blank,
        ),
      ];
      final deletedContender = Contender.empty().copyWith(
        id: '2',
        name: 'Contender 2',
        listType: ListType.fake,
      );
      when(
        () => contenderListNotifier.contenderRepository.deleteContender(
          deletedContender.id,
        ),
      ).thenAnswer((_) async => true);
      contenderListNotifier.state = AsyncValue.data(contenders);
      await contenderListNotifier.deleteContender(deletedContender);

      expect(
        contenderListNotifier.state.when(
          data: (contenders) => contenders,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        contenders
            .where((contender) => contender.id != deletedContender.id)
            .toList(),
      );
    });

    test('copy', () async {
      final contenders = [
        Contender.empty().copyWith(
          id: '1',
          name: 'Contender 1',
          listType: ListType.serious,
        ),
        Contender.empty().copyWith(
          id: '2',
          name: 'Contender 2',
          listType: ListType.fake,
        ),
        Contender.empty().copyWith(
          id: '3',
          name: 'Contender 3',
          listType: ListType.blank,
        ),
      ];
      contenderListNotifier.state = AsyncValue.data(contenders);
      final result = await contenderListNotifier.copy();

      expect(
        result.when(
          data: (contenders) => contenders,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        contenders,
      );
    });

    test('should shuffle serious, fake, and blank lists', () {
      final contenders = [
        Contender.empty().copyWith(
          id: '1',
          name: 'Contender 1',
          listType: ListType.serious,
        ),
        Contender.empty().copyWith(
          id: '2',
          name: 'Contender 2',
          listType: ListType.fake,
        ),
        Contender.empty().copyWith(
          id: '3',
          name: 'Contender 3',
          listType: ListType.blank,
        ),
      ];

      contenderListNotifier.state = AsyncValue.data(contenders);
      contenderListNotifier.shuffle();

      expect(
        contenderListNotifier.state.when(
          data: (contenders) => contenders,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        isNot(contenders),
      );
    });
  });
}
