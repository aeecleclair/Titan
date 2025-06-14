import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/tools/functions.dart';

class CopiabledText extends StatelessWidget {
  const CopiabledText(
    this.data, {
    super.key,
    required this.style,
    this.maxLines = 1,
  });

  final String data;
  final TextStyle style;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SelectableText(
      data,
      maxLines: maxLines,
      style: style,
      onTap: () {
        Clipboard.setData(ClipboardData(text: data));
        displayToastWithContext(TypeMsg.msg, PhonebookTextConstants.copied);
      },
    );
  }
}
