import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class DeleteButton extends StatelessWidget {
  final Future Function() onDelete;
  final bool deactivated;
  final bool deletion;

  const DeleteButton({
    super.key,
    required this.onDelete,
    required this.deactivated,
    required this.deletion,
  });

  @override
  Widget build(BuildContext context) {
    return WaitingButton(
      builder: (child) => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: !deactivated
                ? [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.primaryFixed,
                  ]
                : [
                    Theme.of(context).colorScheme.secondaryFixed,
                    Theme.of(context).colorScheme.tertiary,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: !deactivated
                  ? Theme.of(context).colorScheme.primaryFixed.withOpacity(0.2)
                  : Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(2, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
      onTap: !deactivated ? onDelete : () async {},
      child: HeroIcon(
        deletion ? HeroIcons.trash : HeroIcons.noSymbol,
        size: 30,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
