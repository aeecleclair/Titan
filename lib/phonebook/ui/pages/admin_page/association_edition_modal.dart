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
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';

class AssociationEditionModal extends HookConsumerWidget {
  final Association association;
  final AssociationGroupement groupement;
  final bool isPhonebookAdmin;
  final bool isAdmin;
  const AssociationEditionModal({
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

    AppLocalizations localizeWithContext() {
      return AppLocalizations.of(context)!;
    }

    return BottomModalTemplate(
      title: "title",
      child: SingleChildScrollView(
        child: Column(
          children: [
            Button(
              text: "Modifier les informations",
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
            if (isAdmin) ...[
              SizedBox(height: 5),
              Button(
                text: "Gérer les groupes",
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
            SizedBox(height: 5),
            Button(
              text: "Gérer les membres",
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
            SizedBox(height: 15),
            Button.danger(
              text: "Passer au mandat ${association.mandateYear + 1}",
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => CustomDialogBox(
                    title: "title",
                    descriptions: "descriptions",
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
                          localizeWithContext().phonebookUpdatedAssociation,
                        );
                      } else {
                        displayToastWithContext(
                          TypeMsg.error,
                          localizeWithContext().phonebookUpdatingError,
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
                  ? "Supprimer l'association"
                  : "Désactiver l'association",
              onPressed: () async {
                Navigator.of(context).pop();
                if (!association.deactivated) {
                  final result = await associationListNotifier
                      .deactivateAssociation(association);
                  if (result) {
                    displayToastWithContext(
                      TypeMsg.msg,
                      localizeWithContext().phonebookDeactivatedAssociation,
                    );
                  } else {
                    displayToastWithContext(
                      TypeMsg.error,
                      localizeWithContext().phonebookDeactivatingError,
                    );
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialogBox(
                      title: "title",
                      descriptions: "descriptions",
                      onYes: () async {
                        final result = await associationListNotifier
                            .deleteAssociation(association);
                        if (result) {
                          displayToastWithContext(
                            TypeMsg.msg,
                            localizeWithContext().phonebookDeletedAssociation,
                          );
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            localizeWithContext().phonebookDeletingError,
                          );
                        }
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
