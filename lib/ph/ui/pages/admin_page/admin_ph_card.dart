import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/tools/constants.dart';
import 'package:myecl/ph/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class AdminPhCard extends StatelessWidget {
  final VoidCallback onEdit, onDelete;
  final Ph ph;
  const AdminPhCard({
    super.key,
    required this.ph,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CardLayout(
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      PhTextConstants.nameField,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(shortenText(ph.name, 28)),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      PhTextConstants.dateField,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(shortenText(phFormatDate(ph.date), 28)),
                  ],
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: onEdit,
              child: CardButton(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondaryFixed,
                ],
                child: HeroIcon(
                  HeroIcons.pencil,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onDelete,
              child: CardButton(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.primaryFixed,
                ],
                shadowColor: Theme.of(context)
                    .colorScheme
                    .primaryFixed
                    .withValues(alpha: 0.2),
                child: HeroIcon(
                  HeroIcons.trash,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
