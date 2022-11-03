import 'package:flutter/material.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/tools/constants.dart';

void displayVoteToast(BuildContext context, TypeMsg type, String text) {
  return displayToast(
      context,
      type,
      text,
      VoteColorConstants.green1,
      VoteColorConstants.green2,
      VoteColorConstants.green3,
      VoteColorConstants.green4,
      Colors.white);
}

ListType stringToListType(String type) {
  switch (type) {
    case 'serio':
      return ListType.serio;
    case 'pipo':
      return ListType.pipo;
    default:
      return ListType.pipo;
  }
}
