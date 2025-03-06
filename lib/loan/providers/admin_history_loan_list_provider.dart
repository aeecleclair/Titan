import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/loan/providers/history_loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class AdminHistoryLoanListNotifier extends MapNotifier<Loaner, Loan> {
  AdminHistoryLoanListNotifier() : super();
}

final adminHistoryLoanListProvider = StateNotifierProvider<
    AdminHistoryLoanListNotifier, Map<Loaner, AsyncValue<List<Loan>>?>>((ref) {
  AdminHistoryLoanListNotifier adminLoanListNotifier =
      AdminHistoryLoanListNotifier();
  final loaners = ref.watch(loanerList);
  final loaner = ref.watch(loanerProvider);
  final loanListNotifier = ref.watch(historyLoanerLoanListProvider.notifier);
  adminLoanListNotifier.loadTList(loaners);
  if (loaner.id == EmptyModels.empty<Loaner>().id) {
    return adminLoanListNotifier;
  }
  loanListNotifier.loadLoan(loaner.id).then((value) {
    adminLoanListNotifier.setTData(loaner, value);
  });
  return adminLoanListNotifier;
});
