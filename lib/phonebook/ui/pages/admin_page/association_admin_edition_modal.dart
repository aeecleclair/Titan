import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_picture_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/confirm_modal.dart';

class AssociationAdminEditionModal extends HookConsumerWidget {
  final Association association;
  final AssociationGroupement groupement;
  final bool isPhonebookAdmin;
  final bool isAdmin;
  const AssociationAdminEditionModal({
    super.key,
    required this.association,
    required this.groupement,
    required this.isPhonebookAdmin,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationGroupementsNotifier = ref.watch(
      associationGroupementProvider.notifier,
    );
    final associationNotifier = ref.watch(associationProvider.notifier);
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associationPictureNotifier = ref.watch(
      associationPictureProvider.notifier,
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    AppLocalizations localizeWithContext = AppLocalizations.of(context)!;

    return BottomModalTemplate(
      title: association.name,
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (isPhonebookAdmin) ...[
              Button(
                text: localizeWithContext.phonebookEditAssociationInfo,
                onPressed: () {
                  associationPictureNotifier.getAssociationPicture(
                    association.id,
                  );
                  associationGroupementsNotifier.setAssociationGroupement(
                    groupement,
                  );
                  associationNotifier.setAssociation(association);
                  Navigator.of(context).pop();
                  QR.to(
                    PhonebookRouter.root +
                        PhonebookRouter.admin +
                        PhonebookRouter.addEditAssociation,
                  );
                },
              ),
              SizedBox(height: 5),
              Button(
                text: localizeWithContext.phonebookEditAssociationMembers,
                onPressed: () {
                  associationGroupementsNotifier.setAssociationGroupement(
                    groupement,
                  );
                  associationNotifier.setAssociation(association);
                  Navigator.of(context).pop();
                  QR.to(
                    PhonebookRouter.root +
                        PhonebookRouter.admin +
                        PhonebookRouter.editAssociationMembers,
                  );
                },
              ),
            ],
            if (isAdmin) ...[
              SizedBox(height: 5),
              Button(
                text: localizeWithContext.phonebookEditAssociationGroups,
                onPressed: () {
                  associationGroupementsNotifier.setAssociationGroupement(
                    groupement,
                  );
                  associationNotifier.setAssociation(association);
                  Navigator.of(context).pop();
                  QR.to(
                    PhonebookRouter.root +
                        PhonebookRouter.admin +
                        PhonebookRouter.editAssociationGroups,
                  );
                },
              ),
            ],
            if (isPhonebookAdmin) ...[
              SizedBox(height: 15),
              Button.danger(
                text: localizeWithContext.phonebookChangeTermYear(
                  association.mandateYear + 1,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  showCustomBottomModal(
                    context: context,
                    ref: ref,
                    modal: ConfirmModal.danger(
                      title: localizeWithContext.phonebookChangeTermYear(
                        association.mandateYear + 1,
                      ),
                      description: localizeWithContext.globalIrreversibleAction,
                      onYes: () async {
                        final result = await associationListNotifier
                            .updateAssociation(
                              association.copyWith(
                                mandateYear: association.mandateYear + 1,
                              ),
                            );
                        if (result) {
                          displayToastWithContext(
                            TypeMsg.msg,
                            localizeWithContext.phonebookUpdatedAssociation,
                          );
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            localizeWithContext.phonebookUpdatingError,
                          );
                        }
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 5),
              Button.danger(
                text: association.deactivated
                    ? localizeWithContext.phonebookDeleteAssociation
                    : localizeWithContext.phonebookDeactivateAssociation,
                onPressed: () async {
                  Navigator.of(context).pop();
                  showCustomBottomModal(
                    context: context,
                    ref: ref,
                    modal: ConfirmModal.danger(
                      title: association.deactivated
                          ? localizeWithContext
                                .phonebookDeleteSelectedAssociation(
                                  association.name,
                                )
                          : localizeWithContext
                                .phonebookDeactivateSelectedAssociation(
                                  association.name,
                                ),
                      description: association.deactivated
                          ? localizeWithContext
                                .phonebookDeleteAssociationDescription
                          : localizeWithContext.globalIrreversibleAction,
                      onYes: association.deactivated
                          ? () async {
                              final result = await associationListNotifier
                                  .deactivateAssociation(association);
                              if (result) {
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  localizeWithContext
                                      .phonebookDeactivatedAssociation,
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  localizeWithContext
                                      .phonebookDeactivatingError,
                                );
                              }
                            }
                          : () async {
                              final result = await associationListNotifier
                                  .deleteAssociation(association);
                              if (result) {
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  localizeWithContext
                                      .phonebookDeletedAssociation,
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  localizeWithContext.phonebookDeletingError,
                                );
                              }
                            },
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
