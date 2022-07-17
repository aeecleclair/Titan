import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';

class LoanListNotifier extends StateNotifier<AsyncValue<List<Loan>>> {
  final LoanRepository _repository = LoanRepository();
  LoanListNotifier() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loan>>> loadLoanList() async {
    try {
      final loans = await _repository.getLoanList();
      state = AsyncValue.data(loans);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<bool> addLoan(Loan loan) async {
    return state.when(
      data: (loans) async {
        try {
          await _repository.createLoan(loan);
          loans.add(loan);
          state = AsyncValue.data(loans);
          return true;
        } catch (e) {
          state = AsyncValue.data(loans);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot add loan while loading");
        return false;
      },
    );
  }

  Future<bool> updateLoan(Loan loan) async {
    return state.when(
      data: (loans) async {
        try {
          await _repository.updateLoan(loan);
          var index = loans.indexWhere((element) => element.id == loan.id);
          loans[index] = loan;
          state = AsyncValue.data(loans);
          return true;
        } catch (e) {
          state = AsyncValue.data(loans);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot update loan while loading");
        return false;
      },
    );
  }

  Future<bool> deleteLoan(Loan loan) async {
    return state.when(
      data: (loans) async {
        try {
          await _repository.deleteLoan(loan);
          loans.remove(loan);
          state = AsyncValue.data(loans);
          return true;
        } catch (e) {
          state = AsyncValue.data(loans);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot delete loan while loading");
        return false;
      },
    );
  }
}

final loanListProvider =
    StateNotifierProvider<LoanListNotifier, AsyncValue<List<Loan>>>((ref) {
  LoanListNotifier _loanListNotifier = LoanListNotifier();
  _loanListNotifier.loadLoanList();
  return _loanListNotifier;
});
