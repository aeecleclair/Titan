import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/class/section.dart';

class SideItem extends HookConsumerWidget {
  final Section section;
  final bool isSelected;
  final void Function() onTap;
  const SideItem(
      {super.key,
      required this.section,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: RotatedBox(
          quarterTurns: 3,
          child: Container(
            margin:
                const EdgeInsets.only(left: 25, bottom: 35, right: 25, top: 5),
            child: Column(
              children: [
                Text(section.name,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? const Color.fromARGB(255, 1, 40, 72)
                            : Colors.grey.shade500)),
                const SizedBox(
                  height: 7,
                ),
                isSelected
                    ? Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 1, 40, 72),
                          shape: BoxShape.circle,
                        ),
                      )
                    : const SizedBox(
                        width: 8,
                        height: 8,
                      ),
              ],
            ),
          ),
        ),
    );
  }
}
