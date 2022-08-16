import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class LoanHistoryNotifier extends ListNotifier<Loan> {
  final LoanRepository _loanrepository = LoanRepository();
  LoanHistoryNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _loanrepository.setToken(token);
  }

  Future<AsyncValue<List<Loan>>> loadHistory() async {
    return await loadList(_loanrepository.getHistory);
  }

  void addLoan(Loan loan) {
    state.when(data: (loans) {
      loans.add(loan);
      state = AsyncValue.data(loans);
    }, error: (e, s) {
      state = AsyncValue.error(e);
    }, loading: () {
      state = const AsyncValue.loading();
    });
  }
}

final loanHistoryProvider =
    StateNotifierProvider<LoanHistoryNotifier, AsyncValue<List<Loan>>>((ref) {
  final token = ref.watch(tokenProvider);
  LoanHistoryNotifier _loanHistoryNotifier = LoanHistoryNotifier(token: token);
  _loanHistoryNotifier.loadHistory();
  return _loanHistoryNotifier;
});
