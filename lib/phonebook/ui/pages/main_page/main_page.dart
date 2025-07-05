import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/phonebook/providers/association_filtered_list_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_list_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/is_phonebook_admin_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/phonebook/ui/components/groupement_bar.dart';
import 'package:titan/phonebook/ui/pages/main_page/association_card.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/phonebook/ui/pages/main_page/research_bar.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:tuple/tuple.dart';

class PhonebookMainPage extends HookConsumerWidget {
  const PhonebookMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);
    final isAdmin = ref.watch(isAdminProvider);
    final associationNotifier = ref.watch(associationProvider.notifier);
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associationList = ref.watch(associationListProvider);
    final associationGroupementList = ref.watch(
      associationGroupementListProvider,
    );
    final associationFilteredList = ref.watch(associationFilteredListProvider);
    final associationGroupementListNotifier = ref.watch(
      associationGroupementListProvider.notifier,
    );
    final associationGroupementNotifier = ref.watch(
      associationGroupementProvider.notifier,
    );

    return PhonebookTemplate(
      child: Refresher(
        onRefresh: () async {
          await associationGroupementListNotifier.loadAssociationGroupement();
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
                          associationGroupementNotifier
                              .resetAssociationGroupement();
                          QR.to(PhonebookRouter.root + PhonebookRouter.admin);
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Async2Children(
              values: Tuple2(associationList, associationGroupementList),
              builder: (context, associations, associationGroupements) {
                return Column(
                  children: [
                    GroupementsBar(),
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
                                groupement: associationGroupements.firstWhere(
                                  (groupement) =>
                                      groupement.id == association.groupementId,
                                ),
                                onClicked: () {
                                  associationNotifier.setAssociation(
                                    association,
                                  );
                                  associationGroupementNotifier
                                      .setAssociationGroupement(
                                        associationGroupements.firstWhere(
                                          (groupement) =>
                                              groupement.id ==
                                              association.groupementId,
                                        ),
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
