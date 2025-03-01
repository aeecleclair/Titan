import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/user/class/simple_users.dart';

class BorrowerNotifier extends StateNotifier<SimpleUser> {
  BorrowerNotifier(super.borrower);

  void setBorrower(SimpleUser borrower) {
    state = borrower;
  }
}

final borrowerProvider =
    StateNotifierProvider<BorrowerNotifier, SimpleUser>((ref) {
  final loan = ref.watch(loanProvider);
  return BorrowerNotifier(loan.borrower);
});
