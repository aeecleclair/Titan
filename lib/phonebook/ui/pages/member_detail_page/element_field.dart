import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/tools/functions.dart';

class ElementField extends StatelessWidget {
  final String label;
  final String value;
  const ElementField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          Center(child: Text(label, style: const TextStyle(fontSize: 16))),
          Center(
            child: SelectableText(
              value,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              onTap: () {
                Clipboard.setData(ClipboardData(text: value));
                displayToastWithContext(
                  TypeMsg.msg,
                  PhonebookTextConstants.copied,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
