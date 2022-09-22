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
    return await update(_loanrepository.updateLoan, (loans, loan) {
      final index = loans.indexWhere((l) => l.id == loan.id);
      loans[index] = loan;
      return loans;
    }, loan);
  }

  Future<bool> deleteLoan(Loan loan) async {
    return await delete(
        _loanrepository.deleteLoan,
        (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
        loan.id,
        loan);
  }

  Future<bool> returnLoan(Loan loan) async {
    return await delete(
        _loanrepository.returnLoan,
        (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
        loan.id,
        loan);
  }
}

final loanListProvider =
    StateNotifierProvider<LoanListNotifier, AsyncValue<List<Loan>>>((ref) {
  final token = ref.watch(tokenProvider);
  LoanListNotifier loanListNotifier = LoanListNotifier(token: token);
  loanListNotifier.loadLoanList();
  return loanListNotifier;
});
