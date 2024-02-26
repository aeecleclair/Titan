import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

class ElementField extends StatelessWidget {
  final String label;
  final String value;
  const ElementField({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                  label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ))),
            Expanded(
                flex: 4,
                child: Center(
                    child: SelectableText(
                  value,
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: value));
                    displayToastWithContext(
                        TypeMsg.msg, PhonebookTextConstants.copied);
                  },
                ))),
          ],
        ));
  }
}