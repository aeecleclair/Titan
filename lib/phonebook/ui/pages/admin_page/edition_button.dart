import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
              ? Theme.of(context).colorScheme.secondaryFixed
              : Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 10,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: HeroIcon(
          HeroIcons.pencil,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
