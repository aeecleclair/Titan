import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/providers/association_filtered_list_provider.dart';
import 'package:titan/phonebook/providers/association_kind_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/phonebook_admin_provider.dart';
import 'package:titan/phonebook/providers/roles_tags_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/ui/components/kinds_bar.dart';
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
import 'package:titan/l10n/app_localizations.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationNotifier = ref.watch(associationProvider.notifier);
    final kindNotifier = ref.watch(associationKindProvider.notifier);
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associationList = ref.watch(associationListProvider);
    final associationFilteredList = ref.watch(associationFilteredListProvider);
    final roleNotifier = ref.watch(rolesTagsProvider.notifier);
    final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);
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
            AsyncChild(
              value: associationList,
              builder: (context, associations) {
                return Column(
                  children: [
                    KindsBar(),
                    GestureDetector(
                      onTap: isPhonebookAdmin
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
                        color: isPhonebookAdmin
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
                    if (associations.isEmpty)
                      Center(
                        child: Text(
                          AppLocalizations.of(
                            context,
                          )!.phonebookNoAssociationFound,
                        ),
                      )
                    else
                      ...associationFilteredList.map(
                        (association) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: EditableAssociationCard(
                            association: association,
                            isPhonebookAdmin: isPhonebookAdmin,
                            onEdit: () {
                              kindNotifier.setKind(association.kind);
                              associationNotifier.setAssociation(association);
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
                                          title: AppLocalizations.of(
                                            context,
                                          )!.phonebookDeleting,
                                          descriptions: AppLocalizations.of(
                                            context,
                                          )!.phonebookDeleteAssociation,
                                          onYes: () async {
                                            final deletedAssociationMsg =
                                                AppLocalizations.of(
                                                  context,
                                                )!.phonebookDeletedAssociation;
                                            final deletingErrorMsg =
                                                AppLocalizations.of(
                                                  context,
                                                )!.phonebookDeletingError;
                                            final result =
                                                await associationListNotifier
                                                    .deleteAssociation(
                                                      association,
                                                    );
                                            if (result) {
                                              displayToastWithContext(
                                                TypeMsg.msg,
                                                deletedAssociationMsg,
                                              );
                                            } else {
                                              displayToastWithContext(
                                                TypeMsg.error,
                                                deletingErrorMsg,
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
                                          title: AppLocalizations.of(
                                            context,
                                          )!.phonebookDeactivating,
                                          descriptions: AppLocalizations.of(
                                            context,
                                          )!.phonebookDeactivateAssociation,
                                          onYes: () async {
                                            final deactivatedAssociationMsg =
                                                AppLocalizations.of(
                                                  context,
                                                )!.phonebookDeactivatedAssociation;
                                            final deactivatingErrorMsg =
                                                AppLocalizations.of(
                                                  context,
                                                )!.phonebookDeactivatingError;
                                            final result =
                                                await associationListNotifier
                                                    .deactivateAssociation(
                                                      association,
                                                    );
                                            if (result) {
                                              displayToastWithContext(
                                                TypeMsg.msg,
                                                deactivatedAssociationMsg,
                                              );
                                            } else {
                                              displayToastWithContext(
                                                TypeMsg.error,
                                                deactivatingErrorMsg,
                                              );
                                            }
                                          },
                                        );
                                      },
                                    );
                            },
                          ),
                        ),
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
