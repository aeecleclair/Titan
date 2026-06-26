import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/loan/adapters/item.dart';

extension $Loan on Loan {
  LoanCreation toLoanCreation() {
    return LoanCreation(
      borrowerId: borrowerId,
      loanerId: loanerId,
      start: start,
      end: end,
      itemsBorrowed: itemsQty
          .map((e) => e.itemSimple.toItemBorrowed(e.quantity))
          .toList(),
    );
  }
}
