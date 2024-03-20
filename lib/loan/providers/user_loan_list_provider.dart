import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserLoanListNotifier extends ListNotifier<Loan> {
  final LoanRepository loanrepository;
  UserLoanListNotifier({required this.loanrepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loan>>> loadMyLoanList() async {
    return await loadList(loanrepository.getMyLoanList);
  }

  Future<bool> addLoan(Loan loan) async {
    return await add(loanrepository.createLoan, loan);
  }

  Future<bool> updateLoan(Loan loan) async {
    return await update(
      loanrepository.updateLoan,
      (loans, loan) {
        final index = loans.indexWhere((l) => l.id == loan.id);
        loans[index] = loan;
        return loans;
      },
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
}

final userLoanListProvider =
    StateNotifierProvider<UserLoanListNotifier, AsyncValue<List<Loan>>>((ref) {
  final loanRepository = ref.watch(loanRepositoryProvider);
  UserLoanListNotifier userLoanListNotifier =
      UserLoanListNotifier(loanrepository: loanRepository);
  tokenExpireWrapperAuth(ref, () async {
    await userLoanListNotifier.loadMyLoanList();
  });
  return userLoanListNotifier;
});
