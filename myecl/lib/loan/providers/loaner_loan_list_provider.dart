import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class LoanerLoanListNotifier extends ListNotifier<Loan> {
  final LoanRepository _loanrepository = LoanRepository();
  LoanerLoanListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _loanrepository.setToken(token);
  }

  Future<AsyncValue<List<Loan>>> loadLoan(String loanerId) async {
    return await loadList(
        () async => _loanrepository.getLoanListByLoanerId(loanerId));
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

final loanerLoanListProvider =
    StateNotifierProvider<LoanerLoanListNotifier, AsyncValue<List<Loan>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final loanerId = ref.watch(loanerIdProvider);
  LoanerLoanListNotifier _loanHistoryNotifier =
      LoanerLoanListNotifier(token: token);
  _loanHistoryNotifier.loadLoan(loanerId);
  return _loanHistoryNotifier;
});
