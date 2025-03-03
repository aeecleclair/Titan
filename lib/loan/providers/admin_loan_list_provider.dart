import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AdminLoanListNotifier extends MapNotifier<Loaner, Loan> {
  AdminLoanListNotifier() : super();
}

final adminLoanListProvider = StateNotifierProvider<AdminLoanListNotifier,
    Map<Loaner, AsyncValue<List<Loan>>?>>((ref) {
  AdminLoanListNotifier adminLoanListNotifier = AdminLoanListNotifier();
  tokenExpireWrapperAuth(ref, () async {
    final loaners = ref.watch(loanerList);
    final loaner = ref.watch(loanerProvider);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    adminLoanListNotifier.loadTList(loaners);
    if (loaner.id == EmptyModels.empty<Loaner>().id) {
      return adminLoanListNotifier;
    }
    loanListNotifier.loadLoan(loaner.id).then((value) {
      adminLoanListNotifier.setTData(loaner, value);
    });
  });
  return adminLoanListNotifier;
});
