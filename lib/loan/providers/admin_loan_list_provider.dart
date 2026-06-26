import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/loan/providers/loaner_loan_list_provider.dart';
import 'package:titan/loan/providers/loaner_provider.dart';
import 'package:titan/loan/providers/user_loaner_list_provider.dart';
import 'package:titan/tools/providers/map_provider.dart';

class AdminLoanListNotifier extends MapNotifier<Loaner, Loan> {
  @override
  Map<Loaner, AsyncValue<List<Loan>>?> build() {
    final loaners = ref.watch(loanerList);
    final loaner = ref.watch(loanerProvider);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    loadTList(loaners);
    if (loaner.id == Loaner.empty().id) return state;
    loanListNotifier.loadLoan(loaner.id).then((value) {
      setTData(loaner, value);
    });
    return state;
  }
}

final adminLoanListProvider =
    NotifierProvider<
      AdminLoanListNotifier,
      Map<Loaner, AsyncValue<List<Loan>>?>
    >(() => AdminLoanListNotifier());
