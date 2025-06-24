import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/class/loan.dart';

class LoanNotifier extends StateNotifier<Loan> {
  LoanNotifier() : super(Loan.empty());

  Future<bool> setLoan(Loan loan) async {
    state = loan;
    return true;
  }
}

final loanProvider = StateNotifierProvider<LoanNotifier, Loan>((ref) {
  return LoanNotifier();
});
