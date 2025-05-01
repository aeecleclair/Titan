import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/ui/components/item_card_ui.dart';
import 'package:myecl/admin/ui/pages/groups/group_page/group_button.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class GroupUi extends HookConsumerWidget {
  final SimpleGroup group;
  final void Function() onEdit;
  final Future Function() onDelete;
  final bool isLoaner;
  const GroupUi({
    super.key,
    required this.group,
    required this.onEdit,
    required this.onDelete,
    required this.isLoaner,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ItemCardUi(
      children: [
        const SizedBox(width: 10),
        if (isLoaner)
          Row(
            children: [
              HeroIcon(
                HeroIcons.buildingLibrary,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              const SizedBox(width: 15),
            ],
          ),
        Expanded(
          child: Text(
            group.name,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
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
              child: GroupButton(
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
              builder: (child) => GroupButton(
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
