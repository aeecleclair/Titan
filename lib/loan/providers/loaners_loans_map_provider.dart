import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class LoanersLoansNotifier extends MapNotifier<Loaner, Loan> {
  LoanersLoansNotifier() : super();

  bool removeLoanForLoaner(Loaner loaner, Loan loan) {
    return state[loaner]!.maybeWhen(
      data: (loanList) {
        loanList.removeWhere(
          (itemToTest) => itemToTest.id == loan.id,
        );
        state[loaner] = AsyncValue.data(loanList);
        state = Map.from(state);
        return true;
      },
      orElse: () => false,
    );
  }

  bool updateLoanForLoaner(Loaner loaner, Loan loan) {
    return state[loaner]!.maybeWhen(
      data: (loanList) {
        loanList[loanList.indexWhere((l) => l.id == loan.id)] = loan;
        state[loaner] = AsyncValue.data(loanList);
        state = Map.from(state);
        return true;
      },
      orElse: () => false,
    );
  }

  void addLoanForLoaner(
    Loaner loaner,
    Loan loan,
  ) {
    return state[loaner]!.maybeWhen(
      data: (loanList) {
        loanList.add(loan);
        state[loaner] = AsyncValue.data(loanList);
        state = Map.from(state);
      },
      orElse: () {},
    );
  }
}

final loanersLoansMapProvider = StateNotifierProvider<LoanersLoansNotifier,
    Map<Loaner, AsyncValue<List<Loan>>?>>((ref) {
  final loaners = ref.watch(userLoanerList);
  LoanersLoansNotifier loanerLoanListNotifier = LoanersLoansNotifier();
  loanerLoanListNotifier.loadTList(loaners);
  return loanerLoanListNotifier;
});
