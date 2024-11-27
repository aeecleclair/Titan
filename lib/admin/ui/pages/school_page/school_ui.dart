import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/school.dart';
import 'package:myecl/admin/ui/components/item_card_ui.dart';
import 'package:myecl/admin/ui/pages/school_page/school_button.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class SchoolUi extends HookConsumerWidget {
  final School school;
  final void Function() onEdit;
  final Future Function() onDelete;
  const SchoolUi({
    super.key,
    required this.school,
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
            school.name,
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
              child: SchoolButton(
                gradient1: Colors.grey.shade800,
                gradient2: Colors.grey.shade900,
                child: const HeroIcon(
                  HeroIcons.eye,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            if (school.id != "dce19aa2-8863-4c93-861e-fb7be8f610ed" &&
                school.id != "d9772da7-1142-4002-8b86-b694b431dfed")
              WaitingButton(
                onTap: onDelete,
                builder: (child) => SchoolButton(
                  gradient1: ColorConstants.gradient1,
                  gradient2: ColorConstants.gradient2,
                  child: child,
                ),
                child: const HeroIcon(
                  HeroIcons.xMark,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
