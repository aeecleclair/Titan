import 'package:titan/loan/class/item_quantity.dart';
import 'package:titan/loan/tools/constants.dart';

String formatItems(List<ItemQuantity> itemsQty) {
  return itemsQty.map((e) => "${e.quantity} ${e.itemSimple.name}").join(", ");
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
