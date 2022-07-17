import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';

class LoanHistoryNotifier extends StateNotifier<AsyncValue<List<Loan>>> {
  final LoanRepository _repository = LoanRepository();
  LoanHistoryNotifier() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loan>>> loadHistory() async {
    try {
      final loans = await _repository.getHistory();
      state = AsyncValue.data(loans);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }
}

final loanHistoryProvider =
    StateNotifierProvider<LoanHistoryNotifier, AsyncValue<List<Loan>>>((ref) {
  LoanHistoryNotifier _loanHistoryNotifier = LoanHistoryNotifier();
  _loanHistoryNotifier.loadHistory();
  return _loanHistoryNotifier;
});
