import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/loan/class/loaner.dart';
import 'package:titan/loan/providers/user_loaner_list_provider.dart';
import 'package:titan/loan/repositories/loaner_repository.dart';

class MockLoanerRepository extends Mock implements LoanerRepository {}

void main() {
  group('UserLoanerListNotifier', () {
    late MockLoanerRepository mockLoanerRepository;
    late UserLoanerListNotifier userLoanerListNotifier;

    setUp(() {
      mockLoanerRepository = MockLoanerRepository();
      userLoanerListNotifier = UserLoanerListNotifier(
        loanerRepository: mockLoanerRepository,
      );
    });

    final loaner1 = Loaner.empty().copyWith(id: '1', name: 'Loaner 1');
    final loaner2 = Loaner.empty().copyWith(id: '2', name: 'Loaner 2');
    final loaner3 = Loaner.empty().copyWith(id: '3', name: 'Loaner 3');

    test('loadMyLoanerList returns list of loaners', () async {
      when(
        () => mockLoanerRepository.getMyLoaner(),
      ).thenAnswer((_) async => [loaner1, loaner2, loaner3]);

      final result = await userLoanerListNotifier.loadMyLoanerList();

      expect(
        result.when(
          data: (d) => d,
          error: (e, s) => throw e,
          loading: () => throw Exception('loading'),
        ),
        [loaner1, loaner2, loaner3],
      );
    });

    test('addLoaner adds loaner to list', () async {
      when(
        () => mockLoanerRepository.createLoaner(loaner1),
      ).thenAnswer((_) async => loaner1);
      userLoanerListNotifier.state = AsyncValue.data([loaner2]);

      final result = await userLoanerListNotifier.addLoaner(loaner1);

      expect(result, true);
      expect(
        userLoanerListNotifier.state.when(
          data: (d) => d,
          error: (e, s) => throw e,
          loading: () => throw Exception('loading'),
        ),
        [loaner2, loaner1],
      );
    });

    test('updateLoaner updates loaner in list', () async {
      final updatedLoaner2 = loaner2.copyWith(name: 'Updated Loaner 2');
      when(
        () => mockLoanerRepository.updateLoaner(updatedLoaner2),
      ).thenAnswer((_) async => true);
      userLoanerListNotifier.state = AsyncValue.data([
        loaner1,
        loaner2,
        loaner3,
      ]);

      final result = await userLoanerListNotifier.updateLoaner(updatedLoaner2);

      expect(result, true);
      expect(
        userLoanerListNotifier.state.when(
          data: (d) => d,
          error: (e, s) => throw e,
          loading: () => throw Exception('loading'),
        ),
        [loaner1, updatedLoaner2, loaner3],
      );
    });

    test('deleteLoaner deletes loaner from list', () async {
      when(
        () => mockLoanerRepository.deleteLoaner(loaner2.id),
      ).thenAnswer((_) async => true);
      userLoanerListNotifier.state = AsyncValue.data([
        loaner1,
        loaner2,
        loaner3,
      ]);

      final result = await userLoanerListNotifier.deleteLoaner(loaner2);

      expect(result, true);
      expect(
        userLoanerListNotifier.state.when(
          data: (d) => d,
          error: (e, s) => throw e,
          loading: () => throw Exception('loading'),
        ),
        [loaner1, loaner3],
      );
    });
  });
}
