import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';

final selectedLoanerProvider =
    StateNotifierProvider<LoanerNotifier, Loaner>((ref) {
  final loaners = ref.watch(userLoanerList);
  if (loaners.isEmpty) {
    return LoanerNotifier(Loaner.empty());
  }
  return LoanerNotifier(loaners.first);
});

class LoanerNotifier extends StateNotifier<Loaner> {
  LoanerNotifier(super.id);

  void setLoaner(Loaner loaner) {
    state = loaner;
  }
}
