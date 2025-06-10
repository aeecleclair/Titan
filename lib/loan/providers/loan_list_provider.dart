import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/class/loan.dart';
import 'package:titan/loan/repositories/loan_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class LoanListNotifier extends ListNotifier<Loan> {
  final LoanRepository loanrepository;
  LoanListNotifier({required this.loanrepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loan>>> loadLoanList() async {
    return await loadList(loanrepository.getMyLoanList);
  }

  Future<bool> addLoan(Loan loan) async {
    return await add(loanrepository.createLoan, loan);
  }

  Future<bool> updateLoan(Loan loan) async {
    return await update(loanrepository.updateLoan, (loans, loan) {
      final index = loans.indexWhere((l) => l.id == loan.id);
      loans[index] = loan;
      return loans;
    }, loan);
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

final loanListProvider =
    StateNotifierProvider<LoanListNotifier, AsyncValue<List<Loan>>>((ref) {
      final loanRepository = ref.watch(loanRepositoryProvider);
      LoanListNotifier loanListNotifier = LoanListNotifier(
        loanrepository: loanRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await loanListNotifier.loadLoanList();
      });
      return loanListNotifier;
    });
