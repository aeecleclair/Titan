import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/phonebook/providers/association_filtered_list_provider.dart';
import 'package:titan/phonebook/providers/association_kind_provider.dart';
import 'package:titan/phonebook/providers/association_kinds_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/is_phonebook_admin_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/phonebook/ui/components/kinds_bar.dart';
import 'package:titan/phonebook/ui/pages/main_page/association_card.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/phonebook/ui/pages/main_page/research_bar.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhonebookMainPage extends HookConsumerWidget {
  const PhonebookMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);
    final isAdmin = ref.watch(isAdminProvider);
    final associationNotifier = ref.watch(associationProvider.notifier);
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associationList = ref.watch(associationListProvider);
    final associationFilteredList = ref.watch(associationFilteredListProvider);
    final associationKindsNotifier = ref.watch(
      associationKindsProvider.notifier,
    );
    final kindNotifier = ref.watch(associationKindProvider.notifier);

    return PhonebookTemplate(
      child: Refresher(
        onRefresh: () async {
          await associationKindsNotifier.loadAssociationKinds();
          await associationListNotifier.loadAssociations();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  const ResearchBar(),
                  if (isPhonebookAdmin || isAdmin)
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: AdminButton(
                        onTap: () {
                          kindNotifier.setKind('');
                          QR.to(PhonebookRouter.root + PhonebookRouter.admin);
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            AsyncChild(
              value: associationList,
              builder: (context, associations) {
                return Column(
                  children: [
                    KindsBar(),
                    const SizedBox(height: 30),
                    if (associations.isEmpty)
                      const Center(
                        child: Text(PhonebookTextConstants.noAssociationFound),
                      )
                    else
                      ...associationFilteredList.map(
                        (association) => !association.deactivated
                            ? AssociationCard(
                                association: association,
                                onClicked: () {
                                  associationNotifier.setAssociation(
                                    association,
                                  );
                                  QR.to(
                                    PhonebookRouter.root +
                                        PhonebookRouter.associationDetail,
                                  );
                                },
                              )
                            : const SizedBox.shrink(),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
