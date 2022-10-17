import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/class/section.dart';

class SideItem extends HookConsumerWidget {
  final Section section;
  final bool isSelected;
  const SideItem({super.key, required this.section, required this.isSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        margin: const EdgeInsets.only(left: 50),
        child: Column(
          children: [
            Text(section.name,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Color.fromARGB(255, 1, 40, 72)
                        : Colors.grey.shade500)),
            const SizedBox(
              height: 7,
            ),
            if (isSelected)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 1, 40, 72),
                  shape: BoxShape.circle,
                ),
              )
          ],
        ),
      ),
    );
  }
}
