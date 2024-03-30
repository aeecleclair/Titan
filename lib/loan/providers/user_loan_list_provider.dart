import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserLoanListNotifier extends ListNotifier<Loan> {
  final LoanRepository loanRepository;
  UserLoanListNotifier({required this.loanRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loan>>> loadMyLoanList() async {
    return await loadList(loanRepository.getMyLoanList);
  }

  Future<bool> addLoan(Loan loan) async {
    return await add(loanRepository.createLoan, loan);
  }

  Future<bool> updateLoan(Loan loan) async {
    return await update(
      loanRepository.updateLoan,
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
      loanRepository.deleteLoan,
      (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
      loan.id,
      loan,
    );
  }

  Future<bool> returnLoan(Loan loan) async {
    return await delete(
      loanRepository.returnLoan,
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
      UserLoanListNotifier(loanRepository: loanRepository);
  tokenExpireWrapperAuth(ref, () async {
    await userLoanListNotifier.loadMyLoanList();
  });
  return userLoanListNotifier;
});
