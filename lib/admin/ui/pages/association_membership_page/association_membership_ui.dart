import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/association_membership_simple.dart';
import 'package:titan/super_admin/ui/components/item_card_ui.dart';
import 'package:titan/admin/ui/pages/association_membership_page/association_membership_button.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

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
            style: const TextStyle(
              color: Colors.black,
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
                gradient1: Colors.grey.shade800,
                gradient2: Colors.grey.shade900,
                child: const HeroIcon(HeroIcons.eye, color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            WaitingButton(
              onTap: onDelete,
              builder: (child) => AssociationMembershipButton(
                gradient1: ColorConstants.gradient1,
                gradient2: ColorConstants.gradient2,
                child: child,
              ),
              child: const HeroIcon(HeroIcons.xMark, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
