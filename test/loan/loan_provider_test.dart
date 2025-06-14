import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/class/loan.dart';
import 'package:titan/loan/providers/loan_provider.dart';

void main() {
  group('LoanNotifier', () {
    test('should set loan', () async {
      final container = ProviderContainer();
      final loanNotifier = container.read(loanProvider.notifier);

      final loan = Loan.empty().copyWith(id: '1');

      final result = await loanNotifier.setLoan(loan);

      expect(result, true);
      expect(container.read(loanProvider).id, '1');
    });
  });
}
