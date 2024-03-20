import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class LoanersLoansNotifier extends MapNotifier<Loaner, Loan> {
  LoanersLoansNotifier() : super();
}

final loanersHistoryLoansMapProvider = StateNotifierProvider<
    LoanersLoansNotifier, Map<Loaner, AsyncValue<List<Loan>>?>>((ref) {
  final loaners = ref.watch(userLoanerList);
  LoanersLoansNotifier loanerLoanListNotifier = LoanersLoansNotifier();
  loanerLoanListNotifier.loadTList(loaners);
  return loanerLoanListNotifier;
});
