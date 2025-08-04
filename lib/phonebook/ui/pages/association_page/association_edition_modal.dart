import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_picture_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';

class AssociationEditionModal extends HookConsumerWidget {
  final Association association;
  final AssociationGroupement groupement;
  const AssociationEditionModal({
    super.key,
    required this.association,
    required this.groupement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationGroupementsNotifier = ref.watch(
      associationGroupementProvider.notifier,
    );
    final associationNotifier = ref.watch(associationProvider.notifier);
    final associationPictureNotifier = ref.watch(
      associationPictureProvider.notifier,
    );

    AppLocalizations localizeWithContext = AppLocalizations.of(context)!;

    return BottomModalTemplate(
      title: association.name,
      child: SingleChildScrollView(
        child: Column(
          children: [
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
                      PhonebookRouter.associationDetail +
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
                      PhonebookRouter.associationDetail +
                      PhonebookRouter.editAssociationMembers,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
