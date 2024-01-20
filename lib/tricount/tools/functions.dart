import 'package:flutter/material.dart';
import 'package:myecl/user/class/list_users.dart';

String getAvatarName(SimpleUser user) {
  final name = user.nickname != null
      ? user.nickname!
          .substring(0, user.nickname!.length > 3 ? 3 : user.nickname!.length)
      : user.firstname
          .substring(0, user.firstname.length > 3 ? 3 : user.firstname.length);
  return name;
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

SimpleUser getMember(List<SimpleUser> members, String id) {
  return members.firstWhere((element) => element.id == id);
}