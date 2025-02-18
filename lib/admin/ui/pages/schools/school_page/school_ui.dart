import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/school.dart';
import 'package:myecl/admin/ui/components/item_card_ui.dart';
<<<<<<< HEAD:lib/admin/ui/pages/schools/school_page/school_ui.dart
import 'package:myecl/admin/ui/pages/schools/school_page/school_button.dart';
=======
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/pages/school_page/school_button.dart';
>>>>>>> b0b0df12 (Feat: change admin menu UI):lib/admin/ui/pages/school_page/school_ui.dart
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
            if (school.id != SchoolIdConstant.noSchool.value &&
                school.id != SchoolIdConstant.eclSchool.value)
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
