import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class LoanNotifier extends Notifier<Loan> {
  @override
  Loan build() {
    return Loan.empty();
  }

  Future<bool> setLoan(Loan loan) async {
    state = loan;
    return true;
  }
}

final loanProvider = NotifierProvider<LoanNotifier, Loan>(LoanNotifier.new);
