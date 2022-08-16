import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class LoanNotifier extends SingleNotifier<Loan> {
  final LoanRepository _loanrepository = LoanRepository();
  LoanNotifier({required String token}) : super(const AsyncValue.loading()) {
    _loanrepository.setToken(token);
  }

  Future<AsyncValue<Loan>> loadLoan(String id) async {
    return await load(() async => _loanrepository.getLoan(id));
  }

  void setLoan(Loan loan) {
    state = AsyncValue.data(loan);
  }

  void toggleCaution() {
    state.when(
      data: (l) {
        state = AsyncValue.data(l.copyWith(caution: !l.caution));
      },
      error: (e, s) => state = AsyncValue.error(e),
      loading: () => state = const AsyncValue.loading(),
    );
  }
}

final loanProvider =
    StateNotifierProvider<LoanNotifier, AsyncValue<Loan>>((ref) {
  final token = ref.watch(tokenProvider);
  final loanerId = ref.watch(loanerIdProvider);
  LoanNotifier _loanNotifier = LoanNotifier(token: token);
  _loanNotifier.loadLoan(loanerId);
  return _loanNotifier;
});
