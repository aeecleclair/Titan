import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.enums.swagger.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

void main() {
  group('LoanNotifier', () {
    late ProviderContainer container;
    late LoanNotifier notifier;
    final loan = Loan(
      id: '1',
      start: DateTime.now(),
      end: DateTime.now().add(Duration(days: 7)),
      borrower: CoreUserSimple(
        name: 'Borrower',
        firstname: 'First',
        id: 'borrower1',
        accountType: AccountType.$external,
        schoolId: 'school123',
      ),
      borrowerId: 'borrower1',
      loaner: Loaner(
        name: 'Loaner',
        groupManagerId: 'manager1',
        id: 'loaner1',
      ),
      loanerId: 'loaner1',
      returned: false,
      returnedDate: DateTime.now().add(Duration(days: 7)),
      itemsQty: [],
    );

    setUp(() {
      container = ProviderContainer();
      notifier = container.read(loanProvider.notifier);
    });

    test('setLoan should update state', () {
      notifier.setLoan(loan);

      expect(container.read(loanProvider).id, equals('1'));
      expect(container.read(loanProvider).borrowerId, equals('borrower1'));
      expect(container.read(loanProvider).loanerId, equals('loaner1'));
    });

    test('resetLoan should reset state', () {
      notifier.setLoan(loan);
      notifier.setLoan(Loan.fromJson({}));

      expect(container.read(loanProvider).id, equals(''));
      expect(container.read(loanProvider).borrowerId, equals(''));
      expect(container.read(loanProvider).loanerId, equals(''));
    });
  });
}
