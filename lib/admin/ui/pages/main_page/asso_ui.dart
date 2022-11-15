import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/functions.dart';

class AssoUi extends HookConsumerWidget {
  final String name;
  final void Function() onTap;
  const AssoUi({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(
                    capitalize(name),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  child: const HeroIcon(
                    HeroIcons.chevronRight,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
              ],
            )));
  }
}
