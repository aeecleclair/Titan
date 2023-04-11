import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

String formatItems(List<ItemQuantity> itemsQty) {
  if (itemsQty.length == 2) {
    return "${itemsQty[0].quantity} ${itemsQty[0].item.name} ${LoanTextConstants.and} ${itemsQty[1].quantity} ${itemsQty[1].item.name}";
  } else if (itemsQty.length == 3) {
    return "${itemsQty[0].quantity} ${itemsQty[0].item.name}, ${itemsQty[1].quantity} ${itemsQty[1].item.name} ${LoanTextConstants.and} ${itemsQty[2].quantity} ${itemsQty[2].item.name}";
  } else if (itemsQty.length > 3) {
    return "${itemsQty[0].quantity} ${itemsQty[0].item.name}, ${itemsQty[1].quantity} ${itemsQty[1].item.name} ${LoanTextConstants.and} ${itemsQty.length - 2} ${LoanTextConstants.others}";
  } else if (itemsQty.length == 1) {
    return "${itemsQty[0].quantity} ${itemsQty[0].item.name}";
  } else {
    return "";
  }
}

String numberDaysToIsoDate(int days) {
  return processDateToAPI(DateTime(0, 0, 0).add(Duration(days: days)));
}

int isoDatetoNumberDays(String date) {
  return DateTime.parse(date).difference(DateTime(0, 0, 0)).inDays;
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

String formatDatesOnlyDay(DateTime dateStart, DateTime dateEnd) {
  final start = parseDate(dateStart);
  final end = parseDate(dateEnd);
  if (start[0] == end[0]) {
    return "Le ${start[0].substring(0, start[0].length - 5)}";
  } else {
    return "Du ${start[0].substring(0, start[0].length - 5)} au ${end[0].substring(0, end[0].length - 5)}";
  }
}
