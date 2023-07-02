import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/ui/pages/main_page/association_button.dart';
import 'package:myecl/admin/ui/pages/main_page/card_ui.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class AssociationUi extends HookConsumerWidget {
  final SimpleGroup group;
  final void Function() onEdit;
  final Future Function() onDelete;
  final bool isLoaner;
  const AssociationUi(
      {super.key,
      required this.group,
      required this.onEdit,
      required this.onDelete,
      required this.isLoaner});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardUi(
      children: [
        const SizedBox(
          width: 10,
        ),
        if (isLoaner)
          Row(
            children: [
              HeroIcon(
                HeroIcons.buildingLibrary,
                color: Colors.grey.shade700,
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        Expanded(
          child: Text(
            group.name,
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: onEdit,
              child: AssociationButton(
                gradient1: Colors.grey.shade800,
                gradient2: Colors.grey.shade900,
                child: const HeroIcon(
                  HeroIcons.eye,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ShrinkButton(
                waitChild: const AssociationButton(
                  gradient1: ColorConstants.gradient1,
                  gradient2: ColorConstants.gradient2,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: onDelete,
                child: const AssociationButton(
                  gradient1: ColorConstants.gradient1,
                  gradient2: ColorConstants.gradient2,
                  child: HeroIcon(
                    HeroIcons.xMark,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
