import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class AdminLoanListNotifier extends MapNotifier<Loaner, Loan> {
  AdminLoanListNotifier({required String token}) : super(token: token);
}

final adminLoanListProvider = StateNotifierProvider<AdminLoanListNotifier,
    AsyncValue<Map<Loaner, AsyncValue<List<Loan>>>>>((ref) {
  final token = ref.watch(tokenProvider);
  final loaners = ref.watch(loanerList);
  final loaner = ref.watch(loanerProvider);
  final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
  AdminLoanListNotifier adminloanListNotifier =
      AdminLoanListNotifier(token: token);
  adminloanListNotifier.loadTList(loaners);
  if (loaner.id == Loaner.empty().id) return adminloanListNotifier;
  loanListNotifier.loadLoan(loaner.id).then((value) {
    adminloanListNotifier.setTData(loaner, value);
  });
  return adminloanListNotifier;
});
