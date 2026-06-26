import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/loan/providers/loaner_list_provider.dart';
import 'package:titan/tools/repository/repository.dart';

class MockLoanerRepository extends Mock implements Openapi {}

void main() {
  group('LoanerListNotifier', () {
    late MockLoanerRepository mockRepository;
    late ProviderContainer container;
    late LoanerListNotifier provider;
    final loaners = [
      Loaner.empty().copyWith(id: '1'),
      Loaner.empty().copyWith(id: '2'),
    ];
    final newLoaner = Loaner.empty().copyWith(id: '3');
    final newLoanerBase = LoanerBase(
      name: newLoaner.name,
      groupManagerId: newLoaner.groupManagerId,
    );
    final updatedLoaner = loaners.first.copyWith(name: 'Updated Loaner');

    setUp(() async {
      mockRepository = MockLoanerRepository();
      // Default stub for the build()-time auto-load.
      when(() => mockRepository.loansLoanersGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), <Loaner>[]),
      );
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
      provider = container.read(loanerListProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('loadLoanerList returns expected data', () async {
      when(() => mockRepository.loansLoanersGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), loaners),
      );

      final result = await provider.loadLoanerList();

      expect(result.maybeWhen(data: (data) => data, orElse: () => []), loaners);
    });

    test('loadLoanerList handles error', () async {
      when(
        () => mockRepository.loansLoanersGet(),
      ).thenThrow(Exception('Failed to load loaners'));

      final result = await provider.loadLoanerList();

      expect(
        result.maybeWhen(error: (error, _) => error, orElse: () => null),
        isA<Exception>(),
      );
    });

    test('addLoaner adds a loaner to the list', () async {
      when(() => mockRepository.loansLoanersGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), loaners),
      );
      when(
        () => mockRepository.loansLoanersPost(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), newLoaner),
      );

      provider.state = AsyncValue.data([...loaners]);
      final result = await provider.addLoaner(newLoanerBase);

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        ...loaners,
        newLoaner,
      ]);
    });

    test('addLoaner handles error', () async {
      when(
        () => mockRepository.loansLoanersPost(body: any(named: 'body')),
      ).thenThrow(Exception('Failed to add loaner'));

      provider.state = AsyncValue.data([...loaners]);
      final result = await provider.addLoaner(newLoanerBase);

      expect(result, false);
    });

    test('updateLoaner updates a loaner in the list', () async {
      when(() => mockRepository.loansLoanersGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), loaners),
      );
      when(
        () => mockRepository.loansLoanersLoanerIdPatch(
          loanerId: any(named: 'loanerId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async =>
            chopper.Response(http.Response('body', 200), updatedLoaner),
      );

      provider.state = AsyncValue.data([...loaners]);
      final result = await provider.updateLoaner(updatedLoaner);

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        updatedLoaner,
        ...loaners.skip(1),
      ]);
    });

    test('updateLoaner handles error', () async {
      when(
        () => mockRepository.loansLoanersLoanerIdPatch(
          loanerId: any(named: 'loanerId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update loaner'));

      provider.state = AsyncValue.data([...loaners]);
      final result = await provider.updateLoaner(updatedLoaner);

      expect(result, false);
    });

    test('deleteLoaner removes a loaner from the list', () async {
      when(() => mockRepository.loansLoanersGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), loaners),
      );
      when(
        () => mockRepository.loansLoanersLoanerIdDelete(
          loanerId: any(named: 'loanerId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), null),
      );

      provider.state = AsyncValue.data([...loaners]);
      final result = await provider.deleteLoaner(loaners.first);

      expect(result, true);
      expect(
        provider.state.maybeWhen(data: (data) => data, orElse: () => []),
        loaners.skip(1).toList(),
      );
    });

    test('deleteLoaner handles error', () async {
      when(
        () => mockRepository.loansLoanersLoanerIdDelete(
          loanerId: loaners.first.id,
        ),
      ).thenThrow(Exception('Failed to delete loaner'));

      provider.state = AsyncValue.data([...loaners]);
      final result = await provider.deleteLoaner(loaners.first);

      expect(result, false);
    });
  });
}
