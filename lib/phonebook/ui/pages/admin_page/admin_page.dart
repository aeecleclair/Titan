import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/phonebook/providers/association_filtered_list_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_list_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/is_phonebook_admin_provider.dart';
import 'package:titan/phonebook/providers/roles_tags_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/phonebook/ui/components/groupement_bar.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/phonebook/ui/pages/admin_page/association_research_bar.dart';
import 'package:titan/phonebook/ui/pages/admin_page/editable_association_card.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:tuple/tuple.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationNotifier = ref.watch(associationProvider.notifier);
    final associationGroupementsNotifier = ref.watch(
      associationGroupementProvider.notifier,
    );
    final associationGroupementList = ref.watch(
      associationGroupementListProvider,
    );
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associationList = ref.watch(associationListProvider);
    final associationFilteredList = ref.watch(associationFilteredListProvider);
    final roleNotifier = ref.watch(rolesTagsProvider.notifier);
    final isAdmin = ref.watch(isAdminProvider);
    final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);
    final groupementAdminProviderList = ref.watch(groupementAdminProvider);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PhonebookTemplate(
      child: Refresher(
        onRefresh: () async {
          await associationListNotifier.loadAssociations();
          await roleNotifier.loadRolesTags();
        },
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(30),
              child: AssociationResearchBar(),
            ),
            const SizedBox(height: 10),
            Async2Children(
              values: Tuple2(associationList, associationGroupementList),
              builder:
                  (
                    context,
                    syncAssociationList,
                    syncAssociationGroupementList,
                  ) {
                    return Column(
                      children: [
                        GroupementsBar(
                          isAdmin: isPhonebookAdmin,
                          restrictToManaged: !isPhonebookAdmin,
                        ),
                        GestureDetector(
                          onTap:
                              isPhonebookAdmin ||
                                  groupementAdminProviderList.isNotEmpty
                              ? () {
                                  QR.to(
                                    PhonebookRouter.root +
                                        PhonebookRouter.admin +
                                        PhonebookRouter.createAssociaiton,
                                  );
                                }
                              : null,
                          child: CardLayout(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                              top: 20,
                              left: 40,
                              right: 40,
                            ),
                            width: double.infinity,
                            height: 100,
                            color:
                                isPhonebookAdmin ||
                                    groupementAdminProviderList.isNotEmpty
                                ? Colors.white
                                : ColorConstants.deactivated2,
                            child: Center(
                              child: HeroIcon(
                                HeroIcons.plus,
                                size: 40,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),
                        if (syncAssociationList.isEmpty)
                          const Center(
                            child: Text(
                              PhonebookTextConstants.noAssociationFound,
                            ),
                          )
                        else
                          ...associationFilteredList.map((association) {
                            if (!isPhonebookAdmin || !isAdmin) {
                              if (!groupementAdminProviderList.any(
                                (groupement) =>
                                    groupement.id == association.groupementId,
                              )) {
                                return const SizedBox.shrink();
                              }
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: EditableAssociationCard(
                                association: association,
                                associationGroupement:
                                    syncAssociationGroupementList.firstWhere(
                                      (groupement) =>
                                          groupement.id ==
                                          association.groupementId,
                                    ),
                                canDelete:
                                    isPhonebookAdmin ||
                                    groupementAdminProviderList.any(
                                      (groupement) =>
                                          groupement.id ==
                                          association.groupementId,
                                    ),
                                canEdit:
                                    isPhonebookAdmin ||
                                    groupementAdminProviderList.any(
                                      (groupement) =>
                                          groupement.id ==
                                          association.groupementId,
                                    ) ||
                                    isAdmin,
                                onEdit: () {
                                  associationGroupementsNotifier
                                      .setAssociationGroupement(
                                        syncAssociationGroupementList
                                            .firstWhere(
                                              (groupement) =>
                                                  groupement.id ==
                                                  association.groupementId,
                                            ),
                                      );
                                  associationNotifier.setAssociation(
                                    association,
                                  );
                                  QR.to(
                                    PhonebookRouter.root +
                                        PhonebookRouter.admin +
                                        PhonebookRouter.editAssociation,
                                  );
                                },
                                onDelete: () async {
                                  association.deactivated
                                      ? await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CustomDialogBox(
                                              title: PhonebookTextConstants
                                                  .deleting,
                                              descriptions:
                                                  PhonebookTextConstants
                                                      .deleteAssociation,
                                              onYes: () async {
                                                final result =
                                                    await associationListNotifier
                                                        .deleteAssociation(
                                                          association,
                                                        );
                                                if (result) {
                                                  displayToastWithContext(
                                                    TypeMsg.msg,
                                                    PhonebookTextConstants
                                                        .deletedAssociation,
                                                  );
                                                } else {
                                                  displayToastWithContext(
                                                    TypeMsg.error,
                                                    PhonebookTextConstants
                                                        .deletingError,
                                                  );
                                                }
                                              },
                                            );
                                          },
                                        )
                                      : await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CustomDialogBox(
                                              title: PhonebookTextConstants
                                                  .deactivating,
                                              descriptions:
                                                  PhonebookTextConstants
                                                      .deactivateAssociation,
                                              onYes: () async {
                                                final result =
                                                    await associationListNotifier
                                                        .deactivateAssociation(
                                                          association,
                                                        );
                                                if (result) {
                                                  displayToastWithContext(
                                                    TypeMsg.msg,
                                                    PhonebookTextConstants
                                                        .deactivatedAssociation,
                                                  );
                                                } else {
                                                  displayToastWithContext(
                                                    TypeMsg.error,
                                                    PhonebookTextConstants
                                                        .deactivatingError,
                                                  );
                                                }
                                              },
                                            );
                                          },
                                        );
                                },
                              ),
                            );
                          }),
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
