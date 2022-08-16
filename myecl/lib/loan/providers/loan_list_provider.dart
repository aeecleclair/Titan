import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class LoanListNotifier extends ListNotifier<Loan> {
  final LoanRepository _loanrepository = LoanRepository();
  LoanListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _loanrepository.setToken(token);
  }

  Future<AsyncValue<List<Loan>>> loadLoanList() async {
    return await loadList(_loanrepository.getMyLoanList);
  }

  Future<bool> addLoan(Loan loan) async {
    return await add(_loanrepository.createLoan, loan);
  }

  Future<bool> updateLoan(Loan loan) async {
    return await update(
        _loanrepository.updateLoan,
        (loans, loan) =>
            loans..[loans.indexWhere((l) => l.id == loan.id)] = loan,
        loan);
  }

  Future<bool> deleteLoan(Loan loan) async {
    return await delete(_loanrepository.deleteLoan, loan.id, loan);
  }
}

final loanListProvider =
    StateNotifierProvider<LoanListNotifier, AsyncValue<List<Loan>>>((ref) {
  final token = ref.watch(tokenProvider);
  LoanListNotifier _loanListNotifier = LoanListNotifier(token: token);
  _loanListNotifier.loadLoanList();
  return _loanListNotifier;
});
