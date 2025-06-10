import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/loan/class/loaner.dart';
import 'package:titan/loan/providers/loaner_list_provider.dart';
import 'package:titan/loan/repositories/loaner_repository.dart';

class MockLoanerRepository extends Mock implements LoanerRepository {}

void main() {
  group('LoanerListNotifier', () {
    late LoanerRepository loanerRepository;
    late LoanerListNotifier loanerListNotifier;

    setUp(() {
      loanerRepository = MockLoanerRepository();
      loanerListNotifier = LoanerListNotifier(
        loanerRepository: loanerRepository,
      );
    });

    test('loadLoanerList', () async {
      final loanerList = [
        Loaner.empty().copyWith(id: '1', name: 'John'),
        Loaner.empty().copyWith(id: '2', name: 'Jane'),
      ];
      when(
        () => loanerRepository.getLoanerList(),
      ).thenAnswer((_) async => loanerList);

      final result = await loanerListNotifier.loadLoanerList();

      expect(
        result.when(
          data: (d) => d,
          error: (e, s) => throw e,
          loading: () => throw Exception('loading'),
        ),
        loanerList,
      );
    });

    test('addLoaner', () async {
      final loaner = Loaner.empty().copyWith(id: '1', name: 'John');
      when(
        () => loanerRepository.createLoaner(loaner),
      ).thenAnswer((_) async => loaner);
      loanerListNotifier.state = AsyncValue.data([Loaner.empty()]);

      final result = await loanerListNotifier.addLoaner(loaner);

      expect(result, true);
    });

    test('updateLoaner', () async {
      final loaner = Loaner.empty().copyWith(id: '1', name: 'John');
      when(
        () => loanerRepository.updateLoaner(loaner),
      ).thenAnswer((_) async => true);
      loanerListNotifier.state = AsyncValue.data([loaner]);

      final result = await loanerListNotifier.updateLoaner(loaner);

      expect(result, true);
    });

    test('deleteLoaner', () async {
      final loaner = Loaner.empty().copyWith(id: '1', name: 'John');
      when(
        () => loanerRepository.deleteLoaner(loaner.id),
      ).thenAnswer((_) async => true);
      loanerListNotifier.state = AsyncValue.data([loaner]);

      final result = await loanerListNotifier.deleteLoaner(loaner);

      expect(result, true);
    });
  });
}
