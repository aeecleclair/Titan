import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/ui/components/item_card_ui.dart';
import 'package:titan/admin/ui/pages/groups/group_page/group_button.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

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
              HeroIcon(HeroIcons.buildingLibrary, color: Colors.grey.shade700),
              const SizedBox(width: 15),
            ],
          ),
        Expanded(
          child: Text(
            group.name,
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
              child: GroupButton(
                gradient1: Colors.grey.shade800,
                gradient2: Colors.grey.shade900,
                child: const HeroIcon(HeroIcons.eye, color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            WaitingButton(
              onTap: onDelete,
              builder: (child) => GroupButton(
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
