import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/loan/adapters/loan.dart';
import 'package:myecl/loan/providers/loan_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;
import 'package:myecl/tools/builders/empty_models.dart';

class MockLoanRepository extends Mock implements Openapi {}

void main() {
  group('LoanListNotifier', () {
    late MockLoanRepository mockRepository;
    late LoanListNotifier provider;
    final loans = [
      EmptyModels.empty<Loan>().copyWith(id: '1'),
      EmptyModels.empty<Loan>().copyWith(id: '2'),
    ];
    final newLoan = EmptyModels.empty<Loan>().copyWith(id: '3');
    final updatedLoan = loans.first.copyWith(notes: 'Updated');

    setUp(() {
      mockRepository = MockLoanRepository();
      provider = LoanListNotifier(loanRepository: mockRepository);
    });

    test('loadLoanList returns expected data', () async {
      when(() => mockRepository.loansUsersMeGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          loans,
        ),
      );

      final result = await provider.loadLoanList();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        loans,
      );
    });

    test('loadLoanList handles error', () async {
      when(() => mockRepository.loansUsersMeGet())
          .thenThrow(Exception('Failed to load loans'));

      final result = await provider.loadLoanList();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });

    test('addLoan adds a loan to the list', () async {
      when(() => mockRepository.loansUsersMeGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          loans,
        ),
      );
      when(() => mockRepository.loansPost(body: any(named: 'body'))).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          newLoan,
        ),
      );

      await provider.loadLoanList();
      final result = await provider.addLoan(newLoan.toLoanCreation());

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [...loans, newLoan],
      );
    });

    test('addLoan handles error', () async {
      when(() => mockRepository.loansPost(body: any(named: 'body')))
          .thenThrow(Exception('Failed to add loan'));

      final result = await provider.addLoan(newLoan.toLoanCreation());

      expect(result, false);
    });

    test('updateLoan updates a loan in the list', () async {
      when(() => mockRepository.loansUsersMeGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          loans,
        ),
      );
      when(
        () => mockRepository.loansLoanIdPatch(
          loanId: any(named: 'loanId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          updatedLoan,
        ),
      );

      await provider.loadLoanList();
      final result = await provider.updateLoan(updatedLoan);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [updatedLoan, ...loans.skip(1)],
      );
    });

    test('updateLoan handles error', () async {
      when(
        () => mockRepository.loansLoanIdPatch(
          loanId: any(named: 'loanId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update loan'));

      final result = await provider.updateLoan(updatedLoan);

      expect(result, false);
    });

    test('deleteLoan removes a loan from the list', () async {
      when(() => mockRepository.loansUsersMeGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          loans,
        ),
      );
      when(() => mockRepository.loansLoanIdDelete(loanId: any(named: 'loanId')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      await provider.loadLoanList();
      final result = await provider.deleteLoan(loans.first.id);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        loans.skip(1).toList(),
      );
    });

    test('deleteLoan handles error', () async {
      when(() => mockRepository.loansLoanIdDelete(loanId: loans.first.id))
          .thenThrow(Exception('Failed to delete loan'));

      final result = await provider.deleteLoan(loans.first.id);

      expect(result, false);
    });

    test('returnLoan returns a loan', () async {
      when(() => mockRepository.loansUsersMeGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          loans,
        ),
      );
      when(
        () => mockRepository.loansLoanIdReturnPost(
          loanId: any(named: 'loanId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      await provider.loadLoanList();
      final result = await provider.returnLoan(loans.first.id);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        loans.skip(1).toList(),
      );
    });

    test('returnLoan handles error', () async {
      when(() => mockRepository.loansLoanIdReturnPost(loanId: loans.first.id))
          .thenThrow(Exception('Failed to return loan'));

      final result = await provider.returnLoan(loans.first.id);

      expect(result, false);
    });
  });
}
