import 'package:flutter/material.dart';

class CheckBoxEntry extends StatelessWidget {
  final String title;
  final ValueNotifier<bool> valueNotifier;
  const CheckBoxEntry(
      {Key? key, required this.title, required this.valueNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        valueNotifier.value = !valueNotifier.value;
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
            ),
          ),
          Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.black,
            value: valueNotifier.value,
            onChanged: (value) {
              valueNotifier.value = value!;
            },
          ),
        ],
      ),
    );
  }
}
