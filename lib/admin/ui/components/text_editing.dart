import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class TextEditing extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const TextEditing({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AlignLeftText(
            padding: const EdgeInsets.only(bottom: 3),
            label,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade500,
          ),
          TextEntry(
            label: label,
            controller: controller,
            color: ColorConstants.gradient1,
          ),
        ],
      ),
    );
  }
}
