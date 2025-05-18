import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;
import 'package:myecl/tools/builders/empty_models.dart';

class MockLoanerRepository extends Mock implements Openapi {}

void main() {
  group('UserLoanerListNotifier', () {
    late MockLoanerRepository mockRepository;
    late UserLoanerListNotifier provider;
    final loaners = [
      EmptyModels.empty<Loaner>().copyWith(id: '1'),
      EmptyModels.empty<Loaner>().copyWith(id: '2'),
    ];
    final newLoaner = EmptyModels.empty<Loaner>().copyWith(id: '3');
    final newLoanerBase = LoanerBase(
      name: newLoaner.name,
      groupManagerId: newLoaner.groupManagerId,
    );
    final updatedLoaner = loaners.first.copyWith(name: 'Updated Loaner');

    setUp(() {
      mockRepository = MockLoanerRepository();
      provider = UserLoanerListNotifier(loanerRepository: mockRepository);
    });

    test('loadMyLoanerList returns expected data', () async {
      when(() => mockRepository.loansUsersMeLoanersGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          loaners,
        ),
      );

      final result = await provider.loadMyLoanerList();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        loaners,
      );
    });

    test('loadMyLoanerList handles error', () async {
      when(() => mockRepository.loansUsersMeLoanersGet())
          .thenThrow(Exception('Failed to load loaners'));

      final result = await provider.loadMyLoanerList();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });

    test('addLoaner adds a loaner to the list', () async {
      when(() => mockRepository.loansLoanersPost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          newLoaner,
        ),
      );

      provider.state = AsyncValue.data([...loaners]);
      final result = await provider.addLoaner(newLoanerBase);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [...loaners, newLoaner],
      );
    });

    test('addLoaner handles error', () async {
      when(() => mockRepository.loansLoanersPost(body: any(named: 'body')))
          .thenThrow(Exception('Failed to add loaner'));

      provider.state = AsyncValue.data([...loaners]);
      final result = await provider.addLoaner(newLoanerBase);

      expect(result, false);
    });

    test('updateLoaner updates a loaner in the list', () async {
      when(
        () => mockRepository.loansLoanersLoanerIdPatch(
          loanerId: any(named: 'loanerId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          updatedLoaner,
        ),
      );

      provider.state = AsyncValue.data([...loaners]);
      final result = await provider.updateLoaner(updatedLoaner);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [updatedLoaner, ...loaners.skip(1)],
      );
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
      when(
        () => mockRepository.loansLoanersLoanerIdDelete(
          loanerId: any(named: 'loanerId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      provider.state = AsyncValue.data([...loaners]);
      final result = await provider.deleteLoaner(loaners.first.id);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
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
      final result = await provider.deleteLoaner(loaners.first.id);

      expect(result, false);
    });
  });
}
