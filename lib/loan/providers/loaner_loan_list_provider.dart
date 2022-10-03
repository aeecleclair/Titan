import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';
import 'package:myecl/tools/exception.dart';
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

  Future<bool> extendLoan(Loan loan, int delay) async {
    return await update((l) async {
      return _loanrepository.extendLoan(l, delay);
    },
        (loans, loan) =>
            loans..[loans.indexWhere((l) => l.id == loan.id)] = loan,
        loan);
  }

  Future<AsyncValue<List<Loan>>> copy() async {
    return state.when(
        loading: () => const AsyncValue.loading(),
        data: (loans) => AsyncValue.data(loans.sublist(0)),
        error: (error, s) => AsyncValue.error(error));
  }

  Future<AsyncValue<List<Loan>>> loadHistory(String loanerId) async {
    try {
      final data = await _loanrepository.getHistory(loanerId);
      return AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e);
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        return state;
      }
    }
  }
}

final loanerLoanListProvider =
    StateNotifierProvider<LoanerLoanListNotifier, AsyncValue<List<Loan>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final loanerId = ref.watch(loanerIdProvider);
  LoanerLoanListNotifier loanerLoanListNotifier =
      LoanerLoanListNotifier(token: token);
  loanerLoanListNotifier.loadLoan(loanerId);
  return loanerLoanListNotifier;
});
