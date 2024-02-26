import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditionButton extends HookConsumerWidget {
  const EditionButton({Key? key, required this.onEdition}) : super(key: key);
  final Future Function() onEdition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        onEdition();
      },
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(2, 3))
          ],
        ),
        child: const HeroIcon(HeroIcons.pencil, color: Colors.black),
      ),
    );
  }
}
