import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/item_quantity.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/tools/constants.dart';

String formatItems(List<ItemQuantity> itemsQty) {
  if (itemsQty.length == 2) {
    return "${itemsQty[0].quantity} ${itemsQty[0].itemSimple.name} ${LoanTextConstants.and} ${itemsQty[1].quantity} ${itemsQty[1].itemSimple.name}";
  } else if (itemsQty.length == 3) {
    return "${itemsQty[0].quantity} ${itemsQty[0].itemSimple.name}, ${itemsQty[1].quantity} ${itemsQty[1].itemSimple.name} ${LoanTextConstants.and} ${itemsQty[2].quantity} ${itemsQty[2].itemSimple.name}";
  } else if (itemsQty.length > 3) {
    return "${itemsQty[0].quantity} ${itemsQty[0].itemSimple.name}, ${itemsQty[1].quantity} ${itemsQty[1].itemSimple.name} ${LoanTextConstants.and} ${itemsQty.length - 2} ${LoanTextConstants.others}";
  } else if (itemsQty.length == 1) {
    return "${itemsQty[0].quantity} ${itemsQty[0].itemSimple.name}";
  } else {
    return "";
  }
}

String formatNumberItems(int n) {
  if (n >= 2) {
    return "$n ${LoanTextConstants.itemsSelected}";
  } else if (n == 1) {
    return "$n ${LoanTextConstants.itemSelected} ";
  } else {
    return LoanTextConstants.noItemSelected;
  }
}

List<Item> filteredItems(List<Item> items, String query) {
  if (query.isEmpty) {
    return items;
  }
  return items
      .where(
        (item) => item.name.toLowerCase().contains(query.toLowerCase()),
      )
      .toList();
}

List<Loan> filteredLoans(List<Loan> loans, String query) {
  if (query.isEmpty) {
    return loans;
  }
  return loans
      .where(
        (loan) =>
            loan.borrower
                .getName()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            loan.itemsQuantity
                .map(
                  (e) => e.itemSimple.name
                      .toLowerCase()
                      .contains(query.toLowerCase()),
                )
                .contains(true),
      )
      .toList();
}
