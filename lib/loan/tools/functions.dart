import 'package:flutter/material.dart';
import 'package:titan/loan/class/item_quantity.dart';
import 'package:titan/l10n/app_localizations.dart';

String formatItems(List<ItemQuantity> itemsQty, BuildContext context) {
  if (itemsQty.length == 2) {
    return "${itemsQty[0].quantity} ${itemsQty[0].itemSimple.name} ${AppLocalizations.of(context)!.loanAnd} ${itemsQty[1].quantity} ${itemsQty[1].itemSimple.name}";
  } else if (itemsQty.length == 3) {
    return "${itemsQty[0].quantity} ${itemsQty[0].itemSimple.name}, ${itemsQty[1].quantity} ${itemsQty[1].itemSimple.name} ${AppLocalizations.of(context)!.loanAnd} ${itemsQty[2].quantity} ${itemsQty[2].itemSimple.name}";
  } else if (itemsQty.length > 3) {
    return "${itemsQty[0].quantity} ${itemsQty[0].itemSimple.name}, ${itemsQty[1].quantity} ${itemsQty[1].itemSimple.name} ${AppLocalizations.of(context)!.loanAnd} ${itemsQty.length - 2} ${AppLocalizations.of(context)!.loanOthers}";
  } else if (itemsQty.length == 1) {
    return "${itemsQty[0].quantity} ${itemsQty[0].itemSimple.name}";
  } else {
    return "";
  }
}

String formatNumberItems(int n, BuildContext context) {
  if (n >= 2) {
    return "$n ${AppLocalizations.of(context)!.loanItemsSelected}";
  } else if (n == 1) {
    return "$n ${AppLocalizations.of(context)!.loanItemSelected} ";
  } else {
    return AppLocalizations.of(context)!.loanNoItemSelected;
  }
}
