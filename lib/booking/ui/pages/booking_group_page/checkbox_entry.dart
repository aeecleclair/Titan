import 'package:flutter/material.dart';

class CheckBoxEntry extends StatelessWidget {
  final String title;
  final ValueNotifier<bool> valueNotifier;
  const CheckBoxEntry(
      {Key? key, required this.title, required this.valueNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      value: valueNotifier.value,
      onChanged: (newValue) {
        if (newValue != null) {
          valueNotifier.value = newValue;
        }
      },
    );
  }
}
