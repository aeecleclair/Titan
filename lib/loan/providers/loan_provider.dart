import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class LoanNotifier extends StateNotifier<Loan> {
  LoanNotifier() : super(Loan.fromJson({}));

  Future<bool> setLoan(Loan loan) async {
    state = loan;
    return true;
  }
}

final loanProvider = StateNotifierProvider<LoanNotifier, Loan>((ref) {
  return LoanNotifier();
});
