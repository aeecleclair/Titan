import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/constants.dart';

class EditionButton extends HookConsumerWidget {
  const EditionButton({
    super.key,
    required this.onEdition,
    required this.deactivated,
  });
  final void Function() onEdition;
  final bool deactivated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: !deactivated ? onEdition : null,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: !deactivated
              ? Colors.grey.shade200
              : ColorConstants.deactivated1,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: const HeroIcon(HeroIcons.pencil, color: Colors.black),
      ),
    );
  }
}
