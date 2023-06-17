import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/tools/constants.dart';

class CustomButton extends HookConsumerWidget {
  const CustomButton({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: TombolaColorConstants.gradient2.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(2, 3),
            ),
          ],
          color: TombolaColorConstants.gradient2,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          const HeroIcon(HeroIcons.userGroup, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text(text,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    );
  }
}
