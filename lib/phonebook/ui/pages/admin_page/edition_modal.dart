import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';

class AssociationEditionModal extends HookConsumerWidget {
  final Association association;
  final AssociationGroupement groupement;
  final bool isPhonebookAdmin;
  const AssociationEditionModal({
    super.key,
    required this.association,
    required this.groupement,
    required this.isPhonebookAdmin,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationGroupementsNotifier = ref.watch(
      associationGroupementProvider.notifier,
    );
    final associationNotifier = ref.watch(associationProvider.notifier);
    final associationListNotifier = ref.watch(associationListProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return BottomModalTemplate(
      title: "title",
      child: SingleChildScrollView(
        child: Column(
          children: [
            Button(
              text: "Modifier les informations",
              onPressed: () {
                associationGroupementsNotifier.setAssociationGroupement(
                  groupement,
                );
                associationNotifier.setAssociation(association);
                QR.to(
                  PhonebookRouter.root +
                      PhonebookRouter.admin +
                      PhonebookRouter.editAssociation,
                );
              },
            ),
            SizedBox(height: 5),
            Button(
              text: "Gérer les groupes",
              onPressed: () {
                associationGroupementsNotifier.setAssociationGroupement(
                  groupement,
                );
                associationNotifier.setAssociation(association);
                QR.to(
                  PhonebookRouter.root +
                      PhonebookRouter.admin +
                      PhonebookRouter.editAssociation,
                );
              },
            ),
            SizedBox(height: 5),
            Button(
              text: "Gérer les membres",
              onPressed: () {
                associationGroupementsNotifier.setAssociationGroupement(
                  groupement,
                );
                associationNotifier.setAssociation(association);
                QR.to(
                  PhonebookRouter.root +
                      PhonebookRouter.admin +
                      PhonebookRouter.editAssociation,
                );
              },
            ),
            SizedBox(height: 15),
            Button.danger(
              text: "Passer au mandat ${association.mandateYear + 1}",
              onPressed: () {
                return null;
              },
            ),
            SizedBox(height: 5),
            ...association.deactivated
                ? [
                    Button.danger(
                      text: "Réactiver l'association",
                      onPressed: () {},
                    ),
                    SizedBox(height: 5),
                  ]
                : [SizedBox.shrink()],
            Button.danger(
              text: association.deactivated
                  ? "Supprimer l'association"
                  : "Désactiver l'association",
              onPressed: () async {
                association.deactivated
                    ? await showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialogBox(
                            title: PhonebookTextConstants.deleting,
                            descriptions:
                                PhonebookTextConstants.deleteAssociation,
                            onYes: () async {
                              final result = await associationListNotifier
                                  .deleteAssociation(association);
                              if (result) {
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  PhonebookTextConstants.deletedAssociation,
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  PhonebookTextConstants.deletingError,
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
                            title: PhonebookTextConstants.deactivating,
                            descriptions:
                                PhonebookTextConstants.deactivateAssociation,
                            onYes: () async {
                              final result = await associationListNotifier
                                  .deactivateAssociation(association);
                              if (result) {
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  PhonebookTextConstants.deactivatedAssociation,
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  PhonebookTextConstants.deactivatingError,
                                );
                              }
                            },
                          );
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
