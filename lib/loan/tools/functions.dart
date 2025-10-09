import 'package:titan/loan/class/item_quantity.dart';
import 'package:titan/loan/tools/constants.dart';

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
