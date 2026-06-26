import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/loan/adapters/loan.dart';
import 'package:titan/loan/providers/loan_list_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;
import 'package:titan/tools/repository/repository.dart';

class MockLoanRepository extends Mock implements Openapi {}

void main() {
  group('LoanListNotifier', () {
    late MockLoanRepository mockRepository;
    late ProviderContainer container;
    late LoanListNotifier provider;
    final loans = [
      Loan.empty().copyWith(id: '1'),
      Loan.empty().copyWith(id: '2'),
    ];
    final newLoan = Loan.empty().copyWith(id: '3');
    final updatedLoan = loans.first.copyWith(notes: 'Updated');

    setUp(() async {
      mockRepository = MockLoanRepository();
      // Default stub for the build()-time auto-load.
      when(() => mockRepository.loansUsersMeGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), <Loan>[]),
      );
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
      provider = container.read(loanListProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('loadLoanList returns expected data', () async {
      when(() => mockRepository.loansUsersMeGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), loans),
      );

      final result = await provider.loadLoanList();

      expect(result.maybeWhen(data: (data) => data, orElse: () => []), loans);
    });

    test('loadLoanList handles error', () async {
      when(
        () => mockRepository.loansUsersMeGet(),
      ).thenThrow(Exception('Failed to load loans'));

      final result = await provider.loadLoanList();

      expect(
        result.maybeWhen(error: (error, _) => error, orElse: () => null),
        isA<Exception>(),
      );
    });

    test('addLoan adds a loan to the list', () async {
      when(() => mockRepository.loansUsersMeGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), loans),
      );
      when(() => mockRepository.loansPost(body: any(named: 'body'))).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), newLoan),
      );

      provider.state = AsyncValue.data([...loans]);
      final result = await provider.addLoan(newLoan.toLoanCreation());

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        ...loans,
        newLoan,
      ]);
    });

    test('addLoan handles error', () async {
      when(
        () => mockRepository.loansPost(body: any(named: 'body')),
      ).thenThrow(Exception('Failed to add loan'));

      provider.state = AsyncValue.data([...loans]);
      final result = await provider.addLoan(newLoan.toLoanCreation());

      expect(result, false);
    });

    test('updateLoan updates a loan in the list', () async {
      when(() => mockRepository.loansUsersMeGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), loans),
      );
      when(
        () => mockRepository.loansLoanIdPatch(
          loanId: any(named: 'loanId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), updatedLoan),
      );

      provider.state = AsyncValue.data([...loans]);
      final result = await provider.updateLoan(updatedLoan);

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        updatedLoan,
        ...loans.skip(1),
      ]);
    });

    test('updateLoan handles error', () async {
      when(
        () => mockRepository.loansLoanIdPatch(
          loanId: any(named: 'loanId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update loan'));

      provider.state = AsyncValue.data([...loans]);
      final result = await provider.updateLoan(updatedLoan);

      expect(result, false);
    });

    test('deleteLoan removes a loan from the list', () async {
      when(() => mockRepository.loansUsersMeGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), loans),
      );
      when(
        () => mockRepository.loansLoanIdDelete(loanId: any(named: 'loanId')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), null),
      );

      provider.state = AsyncValue.data([...loans]);
      final result = await provider.deleteLoan(loans.first);

      expect(result, true);
      expect(
        provider.state.maybeWhen(data: (data) => data, orElse: () => []),
        loans.skip(1).toList(),
      );
    });

    test('deleteLoan handles error', () async {
      when(
        () => mockRepository.loansLoanIdDelete(loanId: loans.first.id),
      ).thenThrow(Exception('Failed to delete loan'));

      provider.state = AsyncValue.data([...loans]);
      final result = await provider.deleteLoan(loans.first);

      expect(result, false);
    });

    test('returnLoan returns a loan', () async {
      when(() => mockRepository.loansUsersMeGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), loans),
      );
      when(
        () =>
            mockRepository.loansLoanIdReturnPost(loanId: any(named: 'loanId')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), null),
      );

      provider.state = AsyncValue.data([...loans]);
      final result = await provider.returnLoan(loans.first);

      expect(result, true);
      expect(
        provider.state.maybeWhen(data: (data) => data, orElse: () => []),
        loans.skip(1).toList(),
      );
    });

    test('returnLoan handles error', () async {
      when(
        () => mockRepository.loansLoanIdReturnPost(loanId: loans.first.id),
      ).thenThrow(Exception('Failed to return loan'));

      provider.state = AsyncValue.data([...loans]);
      final result = await provider.returnLoan(loans.first);

      expect(result, false);
    });
  });
}
