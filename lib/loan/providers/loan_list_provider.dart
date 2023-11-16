import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class LoanListNotifier extends ListNotifier<Loan> {
  final LoanRepository loanRepository = LoanRepository();
  LoanListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    loanRepository.setToken(token);
  }

  Future<AsyncValue<List<Loan>>> loadLoanList() async {
    return await loadList(loanRepository.getMyLoanList);
  }

  Future<bool> addLoan(Loan loan) async {
    return await add(loanRepository.createLoan, loan);
  }

  Future<bool> updateLoan(Loan loan) async {
    return await update(loanRepository.updateLoan, (loans, loan) {
      final index = loans.indexWhere((l) => l.id == loan.id);
      loans[index] = loan;
      return loans;
    }, loan);
  }

  Future<bool> deleteLoan(Loan loan) async {
    return await delete(
        loanRepository.deleteLoan,
        (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
        loan.id,
        loan);
  }

  Future<bool> returnLoan(Loan loan) async {
    return await delete(
        loanRepository.returnLoan,
        (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
        loan.id,
        loan);
  }
}

final loanListProvider =
    StateNotifierProvider<LoanListNotifier, AsyncValue<List<Loan>>>((ref) {
  final token = ref.watch(tokenProvider);
  LoanListNotifier loanListNotifier = LoanListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await loanListNotifier.loadLoanList();
  });
  return loanListNotifier;
});
