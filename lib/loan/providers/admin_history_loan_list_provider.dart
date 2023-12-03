import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/loan/providers/history_loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AdminHistoryLoanListNotifier extends MapNotifier<Loaner, Loan> {
  AdminHistoryLoanListNotifier() : super();
}

final adminHistoryLoanListProvider = StateNotifierProvider<
    AdminHistoryLoanListNotifier,
    AsyncValue<Map<Loaner, AsyncValue<List<Loan>>>>>((ref) {
  AdminHistoryLoanListNotifier adminLoanListNotifier =
      AdminHistoryLoanListNotifier();
  tokenExpireWrapperAuth(ref, () async {
    final loaners = ref.watch(loanerList);
    final loaner = ref.watch(loanerProvider);
    final loanListNotifier = ref.watch(historyLoanerLoanListProvider.notifier);
    adminLoanListNotifier.loadTList(loaners);
    if (loaner.id == Loaner.fromJson({}).id) return adminLoanListNotifier;
    loanListNotifier.loadLoan(loaner.id).then((value) {
      adminLoanListNotifier.setTData(loaner, value);
    });
  });
  return adminLoanListNotifier;
});
