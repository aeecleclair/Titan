import 'package:flutter/material.dart';
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
