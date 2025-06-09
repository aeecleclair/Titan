import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myemapp/admin/class/simple_group.dart';
import 'package:myemapp/admin/ui/components/item_card_ui.dart';
import 'package:myemapp/admin/ui/pages/groups/group_page/group_button.dart';
import 'package:myemapp/tools/constants.dart';
import 'package:myemapp/tools/ui/builders/waiting_button.dart';

class GroupUi extends HookConsumerWidget {
  final SimpleGroup group;
  final void Function() onEdit;
  final Future Function() onDelete;
  const GroupUi({
    super.key,
    required this.group,
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
