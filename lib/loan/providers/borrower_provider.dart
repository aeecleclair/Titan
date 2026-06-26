import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/loan/providers/loan_provider.dart';

class BorrowerNotifier extends Notifier<CoreUserSimple> {
  @override
  CoreUserSimple build() {
    final loan = ref.watch(loanProvider);
    return loan.borrower;
  }

  void setBorrower(CoreUserSimple borrower) {
    state = borrower;
  }
}

final borrowerProvider = NotifierProvider<BorrowerNotifier, CoreUserSimple>(
  BorrowerNotifier.new,
);
