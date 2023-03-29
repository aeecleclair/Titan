import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AdminLoanListNotifier extends MapNotifier<Loaner, Loan> {
  AdminLoanListNotifier() : super();
}

final adminLoanListProvider = StateNotifierProvider<AdminLoanListNotifier,
    AsyncValue<Map<Loaner, AsyncValue<List<Loan>>>>>((ref) {
  AdminLoanListNotifier adminloanListNotifier =
      AdminLoanListNotifier();
  tokenExpireWrapperAuth(ref, () async {
    final loaners = ref.watch(loanerList);
    final loaner = ref.watch(loanerProvider);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    adminloanListNotifier.loadTList(loaners);
    if (loaner.id == Loaner.empty().id) return adminloanListNotifier;
    loanListNotifier.loadLoan(loaner.id).then((value) {
      adminloanListNotifier.setTData(loaner, value);
    });
  });
  return adminloanListNotifier;
});
