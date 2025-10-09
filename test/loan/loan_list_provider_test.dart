import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/loan/class/loan.dart';
import 'package:titan/loan/providers/loan_list_provider.dart';
import 'package:titan/loan/repositories/loan_repository.dart';

class MockLoanRepository extends Mock implements LoanRepository {}

void main() {
  group('LoanListNotifier', () {
    late LoanRepository loanRepository;
    late LoanListNotifier loanListNotifier;

    setUp(() {
      loanRepository = MockLoanRepository();
      loanListNotifier = LoanListNotifier(loanrepository: loanRepository);
    });

    test('loadLoanList returns AsyncValue<List<Loan>>', () async {
      final loans = [
        Loan.empty().copyWith(id: '1'),
        Loan.empty().copyWith(id: '2'),
      ];
      when(() => loanRepository.getMyLoanList()).thenAnswer((_) async => loans);

      final result = await loanListNotifier.loadLoanList();

      expect(
        result.when(
          data: (d) => d,
          error: (e, s) => throw e,
          loading: () => throw Exception('loading'),
        ),
        loans,
      );
    });

    test('addLoan returns true', () async {
      final loan = Loan.empty().copyWith(id: '1');
      when(() => loanRepository.createLoan(loan)).thenAnswer((_) async => loan);
      loanListNotifier.state = AsyncValue.data([Loan.empty()]);
      final result = await loanListNotifier.addLoan(loan);

      expect(result, true);
    });

    test('updateLoan returns true', () async {
      final loan = Loan.empty().copyWith(id: '1');
      when(() => loanRepository.updateLoan(loan)).thenAnswer((_) async => true);
      loanListNotifier.state = AsyncValue.data([loan]);
      final result = await loanListNotifier.updateLoan(loan);

      expect(result, true);
    });

    test('deleteLoan returns true', () async {
      final loan = Loan.empty().copyWith(id: '1');
      when(
        () => loanRepository.deleteLoan(loan.id),
      ).thenAnswer((_) async => true);
      loanListNotifier.state = AsyncValue.data([loan]);
      final result = await loanListNotifier.deleteLoan(loan);

      expect(result, true);
    });

    test('returnLoan returns true', () async {
      final loan = Loan.empty().copyWith(id: '1');
      when(
        () => loanRepository.returnLoan(loan.id),
      ).thenAnswer((_) async => true);
      loanListNotifier.state = AsyncValue.data([loan]);
      final result = await loanListNotifier.returnLoan(loan);

      expect(result, true);
    });
  });
}
