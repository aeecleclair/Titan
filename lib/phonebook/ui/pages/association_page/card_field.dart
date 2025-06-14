import 'package:flutter/material.dart';
import 'package:titan/phonebook/ui/components/copiabled_text.dart';

class CardField extends StatelessWidget {
  final String label;
  final String value;
  final bool showLabel;
  const CardField({
    super.key,
    required this.label,
    required this.value,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showLabel) ...[
              Text(label, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 5),
            ],
            CopiabledText(
              value,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
