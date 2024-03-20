import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class LoanerLoanListNotifier extends ListNotifier<Loan> {
  final LoanRepository loanrepository;
  LoanerLoanListNotifier({required this.loanrepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loan>>> loadLoanList(String loanerId) async {
    return await loadList(
      () async => loanrepository.getLoanListByLoanerId(loanerId),
    );
  }

  Future<bool> addLoan(Loan loan) async {
    return await add(loanrepository.createLoan, loan);
  }

  Future<bool> updateLoan(Loan loan) async {
    return await update(
      loanrepository.updateLoan,
      (loans, loan) => loans..[loans.indexWhere((l) => l.id == loan.id)] = loan,
      loan,
    );
  }

  Future<bool> deleteLoan(Loan loan) async {
    return await delete(
      loanrepository.deleteLoan,
      (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
      loan.id,
      loan,
    );
  }

  Future<bool> returnLoan(Loan loan) async {
    return await delete(
      loanrepository.returnLoan,
      (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
      loan.id,
      loan,
    );
  }

  Future<bool> extendLoan(Loan loan, int delay) async {
    return await update(
      (l) async {
        return loanrepository.extendLoan(l, delay);
      },
      (loans, loan) => loans..[loans.indexWhere((l) => l.id == loan.id)] = loan,
      loan,
    );
  }

  Future<AsyncValue<List<Loan>>> copy() async {
    return state.whenData((loans) => loans.sublist(0));
  }

  Future<AsyncValue<List<Loan>>> loadHistory(String loanerId) async {
    try {
      final data = await loanrepository.getHistory(loanerId);
      return AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        return state;
      }
    }
  }
}

final loanListProvider =
    StateNotifierProvider<LoanerLoanListNotifier, AsyncValue<List<Loan>>>(
        (ref) {
  final loanerRepository = ref.watch(loanRepositoryProvider);
  return LoanerLoanListNotifier(loanrepository: loanerRepository);
});
