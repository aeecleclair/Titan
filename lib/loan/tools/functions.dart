import 'package:flutter/material.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

void displayLoanToast(BuildContext context, TypeMsg type, String text) {
  return displayToast(
      context,
      type,
      text,
      LoanColorConstants.lightGrey,
      LoanColorConstants.darkGrey,
      LoanColorConstants.lightOrange,
      LoanColorConstants.orange,
      Colors.white);
}

String formatItems(List<Item> items) {
  if (items.length == 2) {
    return "${items[0].name} ${LoanTextConstants.and} ${items[1].name}";
  } else if (items.length == 3) {
    return "${items[0].name}, ${items[1].name} ${LoanTextConstants.and} ${items[2].name}";
  } else if (items.length > 3) {
    return "${items[0].name}, ${items[1].name} ${LoanTextConstants.and} ${items.length - 2} ${LoanTextConstants.others}";
  } else if (items.length == 1) {
    return items[0].name;
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
