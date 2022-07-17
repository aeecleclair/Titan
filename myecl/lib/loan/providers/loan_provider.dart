import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';

class LoanNotifier extends StateNotifier<AsyncValue<Loan>> {
  final LoanRepository _repository = LoanRepository();
  LoanNotifier() : super(const AsyncValue.loading());

  Future<AsyncValue<Loan>> loadLoan(String id) async {
    try {
      final loan = await _repository.getLoan(id);
      state = AsyncValue.data(loan);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  void setLoan(Loan loan) {
    state = AsyncValue.data(loan);
  }
}


final loanProvider = StateNotifierProvider<LoanNotifier, AsyncValue<Loan>>(
    (ref) => LoanNotifier());
