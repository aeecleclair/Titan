import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/providers/all_groups_list_provider.dart';
import 'package:titan/admin/providers/assocation_list_provider.dart';
import 'package:titan/admin/ui/pages/association_page/add_association_modal.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';

class AssociationPage extends ConsumerWidget {
  const AssociationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationList = ref.watch(associationListProvider);
    final groups = ref.watch(allGroupList);
    return AdminTemplate(
      child: AsyncChild(
        value: associationList,
        builder: (BuildContext context, associationList) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Association",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Spacer(),
                    CustomIconButton(
                      icon: HeroIcon(
                        HeroIcons.plus,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () async {
                        await showCustomBottomModal(
                          context: context,
                          ref: ref,
                          modal: AddAssociationModal(
                            groups: groups,
                            onSubmit: (group, name) {},
                            ref: ref,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                ...associationList.map((association) => Text(association.name)),
              ],
            ),
          );
        },
      ),
    );
  }
}
