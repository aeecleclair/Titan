import 'package:flutter/material.dart';
import 'package:myecl/tricount/class/equilibrium_transaction.dart';
import 'package:myecl/tricount/class/transaction.dart';
import 'package:myecl/tricount/class/transaction_type.dart';
import 'package:myecl/user/class/list_users.dart';

String getAvatarName(SimpleUser user) {
  final name = user.nickname != null
      ? user.nickname!
          .substring(0, user.nickname!.length > 3 ? 3 : user.nickname!.length)
      : user.firstname
          .substring(0, user.firstname.length > 3 ? 3 : user.firstname.length);
  return name;
}

List<Transaction> getAllUserBalanceTransactions(
    List<EquilibriumTransaction> equilibriumTransactions,
    List<SimpleUser> sharers) {
  final allUsersBalance = {for (var e in sharers) e.id: 0.0};
  for (final equilibriumTransaction in equilibriumTransactions) {
    allUsersBalance[equilibriumTransaction.to.id] =
        allUsersBalance[equilibriumTransaction.to.id]! +
            equilibriumTransaction.amount;
    allUsersBalance[equilibriumTransaction.from.id] =
        allUsersBalance[equilibriumTransaction.from.id]! -
            equilibriumTransaction.amount;
  }
  final allUserBalanceTransactions = <Transaction>[];
  for (final userBalance in allUsersBalance.entries) {
    allUserBalanceTransactions.add(Transaction(
      payer: sharers.firstWhere((element) => element.id == userBalance.key),
      title: '',
      description: null,
      beneficiaries: [],
      amount: userBalance.value,
      type: TransactionType.reimbursement,
      creationDate: DateTime.now(),
    ));
  }
  return allUserBalanceTransactions;
}


bool hasTextOverflow(
  String text, 
  TextStyle style, 
  {double minWidth = 0, 
       double maxWidth = double.infinity, 
       int maxLines = 2
  }) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: minWidth, maxWidth: maxWidth);
  return textPainter.didExceedMaxLines;
}