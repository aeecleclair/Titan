import 'package:flutter/material.dart';

class CheckBoxEntry extends StatelessWidget {
  final String title;
  final ValueNotifier<bool> valueNotifier;
  final Function(bool) onChanged;
  const CheckBoxEntry(
      {Key? key, required this.title, required this.valueNotifier, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      value: valueNotifier.value,
      onChanged: (newValue) {
        if (newValue != null) {
          valueNotifier.value = newValue;
          onChanged(newValue);
        }
      },
    );
  }
}
