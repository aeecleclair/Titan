import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/tools/constants.dart';

class TextInputDialog extends HookConsumerWidget {
  const TextInputDialog({
    super.key,
    required this.controller,
    required this.title,
    required this.text,
    required this.defaultText,
    required this.onConfirm,
  });

  final String title;
  final String text;
  final String defaultText;
  final VoidCallback onConfirm;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    controller.text = defaultText;
    return AlertDialog(
      title: Center(
        child: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black)),
            color: Colors.white,
          ),
          child: Text(title, style: const TextStyle(fontSize: 20)),
        ),
      ),
      content: SizedBox(
        height: 100,
        child: Column(
          children: [
            const SizedBox(height: 25),
            Text(text),
            const SizedBox(height: 5),
            SizedBox(width: 200, child: TextField(controller: controller)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(PhonebookTextConstants.cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text(PhonebookTextConstants.validation),
        ),
      ],
    );
  }
}
