// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/pretendance_list_provider.dart';
import 'package:myecl/vote/repositories/pretendance_repository.dart';

class MockPretendanceRepository extends Mock implements PretendanceRepository {}

void main() {
  group('PretendanceListNotifier', () {
    late PretendanceListNotifier pretendanceListNotifier;

    setUp(() {
      pretendanceListNotifier = PretendanceListNotifier(
        pretendanceRepository: MockPretendanceRepository(),
      );
    });

    test('loadPretendanceList', () async {
      final pretendances = [
        Pretendance.empty()
            .copyWith(id: '1', name: 'Pretendance 1', listType: ListType.pipo),
        Pretendance.empty()
            .copyWith(id: '2', name: 'Pretendance 2', listType: ListType.serio),
        Pretendance.empty()
            .copyWith(id: '3', name: 'Pretendance 3', listType: ListType.blank),
      ];
      when(() =>
              pretendanceListNotifier.pretendanceRepository.getPretendances())
          .thenAnswer((_) async => pretendances);
      await pretendanceListNotifier.loadPretendanceList();
      expect(
        pretendanceListNotifier.state.when(
          data: (pretendances) => pretendances,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        pretendances,
      );
    });

    test('addPretendance', () async {
      final pretendances = [
        Pretendance.empty()
            .copyWith(id: '1', name: 'Pretendance 1', listType: ListType.pipo),
        Pretendance.empty()
            .copyWith(id: '2', name: 'Pretendance 2', listType: ListType.serio),
        Pretendance.empty()
            .copyWith(id: '3', name: 'Pretendance 3', listType: ListType.blank),
      ];
      final newPretendance = Pretendance.empty()
          .copyWith(id: '4', name: 'Pretendance 4', listType: ListType.serio);
      when(() => pretendanceListNotifier.pretendanceRepository
              .createPretendance(newPretendance))
          .thenAnswer((_) async => newPretendance);
      pretendanceListNotifier.state = AsyncValue.data(pretendances.sublist(0));
      await pretendanceListNotifier.addPretendance(newPretendance);

      expect(
        pretendanceListNotifier.state.when(
          data: (pretendances) => pretendances,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        pretendances + [newPretendance],
      );
    });

    test('updatePretendance', () async {
      final pretendances = [
        Pretendance.empty()
            .copyWith(id: '1', name: 'Pretendance 1', listType: ListType.serio),
        Pretendance.empty()
            .copyWith(id: '2', name: 'Pretendance 2', listType: ListType.pipo),
        Pretendance.empty()
            .copyWith(id: '3', name: 'Pretendance 3', listType: ListType.blank),
      ];
      final updatedPretendance = Pretendance.empty().copyWith(
          id: '2', name: 'Pretendance 2 updated', listType: ListType.pipo);
      when(() => pretendanceListNotifier.pretendanceRepository
          .updatePretendance(updatedPretendance)).thenAnswer((_) async => true);
      pretendanceListNotifier.state = AsyncValue.data(pretendances);
      await pretendanceListNotifier.updatePretendance(updatedPretendance);

      expect(
        pretendanceListNotifier.state.when(
          data: (pretendances) => pretendances,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        pretendances
            .map((pretendance) => pretendance.id == updatedPretendance.id
                ? updatedPretendance
                : pretendance)
            .toList(),
      );
    });

    test('deletePretendance', () async {
      final pretendances = [
        Pretendance.empty()
            .copyWith(id: '1', name: 'Pretendance 1', listType: ListType.serio),
        Pretendance.empty()
            .copyWith(id: '2', name: 'Pretendance 2', listType: ListType.pipo),
        Pretendance.empty()
            .copyWith(id: '3', name: 'Pretendance 3', listType: ListType.blank),
      ];
      final deletedPretendance = Pretendance.empty()
          .copyWith(id: '2', name: 'Pretendance 2', listType: ListType.pipo);
      when(() => pretendanceListNotifier.pretendanceRepository
              .deletePretendance(deletedPretendance.id))
          .thenAnswer((_) async => true);
      pretendanceListNotifier.state = AsyncValue.data(pretendances);
      await pretendanceListNotifier.deletePretendance(deletedPretendance);

      expect(
        pretendanceListNotifier.state.when(
          data: (pretendances) => pretendances,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        pretendances
            .where((pretendance) => pretendance.id != deletedPretendance.id)
            .toList(),
      );
    });

    test('copy', () async {
      final pretendances = [
        Pretendance.empty()
            .copyWith(id: '1', name: 'Pretendance 1', listType: ListType.serio),
        Pretendance.empty()
            .copyWith(id: '2', name: 'Pretendance 2', listType: ListType.pipo),
        Pretendance.empty()
            .copyWith(id: '3', name: 'Pretendance 3', listType: ListType.blank),
      ];
      pretendanceListNotifier.state = AsyncValue.data(pretendances);
      final result = await pretendanceListNotifier.copy();

      expect(
        result.when(
          data: (pretendances) => pretendances,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        pretendances,
      );
    });

    test('should shuffle serio, pipo, and blank lists', () {
      final pretendances = [
        Pretendance.empty()
            .copyWith(id: '1', name: 'Pretendance 1', listType: ListType.serio),
        Pretendance.empty()
            .copyWith(id: '2', name: 'Pretendance 2', listType: ListType.pipo),
        Pretendance.empty()
            .copyWith(id: '3', name: 'Pretendance 3', listType: ListType.blank),
      ];

      pretendanceListNotifier.state = AsyncValue.data(pretendances);
      pretendanceListNotifier.shuffle();

      expect(
        pretendanceListNotifier.state.when(
          data: (pretendances) => pretendances,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        isNot(pretendances),
      );
    });
  });
}
