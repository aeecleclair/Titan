import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';

void main() {
  group('LoanPageNotifier', () {
    test('initial state is LoanPage.main', () {
      final container = ProviderContainer();
      final loanPageNotifier = container.read(loanPageProvider.notifier);
      expect(loanPageNotifier.state, LoanPage.main);
    });

    test('setLoanPage updates state', () {
      final container = ProviderContainer();
      final loanPageNotifier = container.read(loanPageProvider.notifier);
      loanPageNotifier.setLoanPage(LoanPage.admin);
      expect(loanPageNotifier.state, LoanPage.admin);
    });
  });
}