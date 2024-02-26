import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

class CopiabledText extends StatelessWidget {
  const CopiabledText(this.data,
      {super.key, required this.style, required this.flex, this.maxLines = 1});

  final String data;
  final TextStyle style;
  final int flex;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Expanded(
        flex: flex,
        child: Center(
            child: SelectableText(
          data,
          maxLines: maxLines,
          style: style,
          onTap: () {
            Clipboard.setData(ClipboardData(text: data));
            displayToastWithContext(TypeMsg.msg, PhonebookTextConstants.copied);
          },
        )));
  }
}
