import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/association_membership_simple.dart';
import 'package:myecl/admin/ui/components/item_card_ui.dart';
import 'package:myecl/admin/ui/pages/memberships/association_membership_page/association_membership_button.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class AssociationMembershipUi extends HookConsumerWidget {
  final AssociationMembership associationMembership;
  final void Function() onEdit;
  final Future Function() onDelete;
  const AssociationMembershipUi({
    super.key,
    required this.associationMembership,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ItemCardUi(
      children: [
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            associationMembership.name,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            GestureDetector(
              onTap: onEdit,
              child: AssociationMembershipButton(
                gradient1: Theme.of(context).colorScheme.secondaryContainer,
                gradient2: Theme.of(context).colorScheme.secondary,
                child: HeroIcon(
                  HeroIcons.eye,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            WaitingButton(
              onTap: onDelete,
              builder: (child) => AssociationMembershipButton(
                gradient1: Theme.of(context).colorScheme.primaryContainer,
                gradient2: Theme.of(context).colorScheme.primaryFixed,
                child: child,
              ),
              child: HeroIcon(
                HeroIcons.xMark,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
