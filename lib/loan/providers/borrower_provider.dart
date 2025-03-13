import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class BorrowerNotifier extends StateNotifier<CoreUserSimple> {
  BorrowerNotifier(super.borrower);

  void setBorrower(CoreUserSimple borrower) {
    state = borrower;
  }
}

final borrowerProvider =
    StateNotifierProvider<BorrowerNotifier, CoreUserSimple>((ref) {
  final loan = ref.watch(loanProvider);
  return BorrowerNotifier(loan.borrower);
});
