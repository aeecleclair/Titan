import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/class/assocation.dart';
import 'package:titan/admin/providers/all_groups_list_provider.dart';
import 'package:titan/admin/providers/assocation_list_provider.dart';
import 'package:titan/admin/ui/pages/association_page/add_association_modal.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';

class AssociationPage extends ConsumerWidget {
  const AssociationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationList = ref.watch(associationListProvider);
    final associationNotifier = ref.watch(associationListProvider.notifier);
    final groups = ref.watch(allGroupList);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    void popWithContext() {
      Navigator.of(context).pop();
    }

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
                            onSubmit: (group, name) {
                              tokenExpireWrapper(ref, () async {
                                final value = await associationNotifier
                                    .createAssociation(
                                      Association.empty().copyWith(
                                        groupId: group.id,
                                        name: name,
                                      ),
                                    );
                                if (value) {
                                  displayToastWithContext(
                                    TypeMsg.msg,
                                    "Association created successfully",
                                  );
                                } else {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    "Failed to create association",
                                  );
                                }
                                popWithContext();
                              });
                            },
                            ref: ref,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Refresher(
                    controller: ScrollController(),
                    onRefresh: () async {
                      await associationNotifier.loadAssociations();
                    },
                    child: Column(
                      children: [
                        ...associationList.map(
                          (association) => Text(association.name),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
