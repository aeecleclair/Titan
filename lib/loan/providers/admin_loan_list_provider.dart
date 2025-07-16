import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/class/loan.dart';
import 'package:titan/loan/class/loaner.dart';
import 'package:titan/loan/providers/loaner_loan_list_provider.dart';
import 'package:titan/loan/providers/loaner_provider.dart';
import 'package:titan/loan/providers/user_loaner_list_provider.dart';
import 'package:titan/tools/providers/map_provider.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class AdminLoanListNotifier extends MapNotifier<Loaner, Loan> {
  AdminLoanListNotifier() : super();
}

final adminLoanListProvider =
    StateNotifierProvider<
      AdminLoanListNotifier,
      Map<Loaner, AsyncValue<List<Loan>>?>
    >((ref) {
      AdminLoanListNotifier adminLoanListNotifier = AdminLoanListNotifier();
      tokenExpireWrapperAuth(ref, () async {
        final loaners = ref.watch(loanerList);
        final loaner = ref.watch(loanerProvider);
        final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
        adminLoanListNotifier.loadTList(loaners);
        if (loaner.id == Loaner.empty().id) return adminLoanListNotifier;
        loanListNotifier.loadLoan(loaner.id).then((value) {
          adminLoanListNotifier.setTData(loaner, value);
        });
      });
      return adminLoanListNotifier;
    });
