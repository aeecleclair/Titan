import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/assocation.dart';
import 'package:titan/admin/providers/all_groups_list_provider.dart';
import 'package:titan/admin/providers/assocation_list_provider.dart';
import 'package:titan/admin/providers/association_logo_provider.dart';
import 'package:titan/admin/providers/associations_logo_map_provider.dart';
import 'package:titan/admin/ui/pages/association_page/edit_association.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';

class AssociationItem extends HookConsumerWidget {
  const AssociationItem({super.key, required this.association});

  final Association association;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(allGroupList);
    final group = groups.firstWhere((group) => group.id == association.groupId);
    final associationLogo = ref.watch(
      associationLogoMapProvider.select((value) => value[association.id]),
    );
    final associationLogoMapNotifier = ref.watch(
      associationLogoMapProvider.notifier,
    );
    final associationLogoNotifier = ref.watch(associationLogoProvider.notifier);
    final associationNotifier = ref.watch(associationListProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    void popWithContext() {
      Navigator.of(context).pop();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListItem(
        title: association.name,
        subtitle: "Géré par : ${group.name}",
        icon: AutoLoaderChild(
          group: associationLogo,
          notifier: associationLogoMapNotifier,
          mapKey: association.id,
          loader: (associationId) =>
              associationLogoNotifier.getAssociationLogo(associationId),
          dataBuilder: (context, data) {
            return CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: Image(image: data.first.image).image,
            );
          },
        ),
        onTap: () async {
          await showCustomBottomModal(
            context: context,
            ref: ref,
            modal: BottomModalTemplate(
              title: association.name,
              child: Column(
                children: [
                  Button(
                    text: "Modifier",
                    onPressed: () async {
                      associationLogoNotifier.getAssociationLogo(
                        association.id,
                      );
                      await showCustomBottomModal(
                        context: context,
                        ref: ref,
                        modal: BottomModalTemplate(
                          title: "Modifier l'association",
                          child: EditAssociation(
                            association: association,
                            group: group,
                          ),
                        ),
                      );
                      popWithContext();
                    },
                  ),
                  SizedBox(height: 10),
                  Button(
                    text: "Supprimer",
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialogBox(
                            title: AppLocalizations.of(context)!.adminDeleting,
                            descriptions: AppLocalizations.of(
                              context,
                            )!.adminDeleteAssociationMembership,
                            onYes: () async {
                              tokenExpireWrapper(ref, () async {
                                final value = await associationNotifier
                                    .deleteAssociation(association);
                                if (value) {
                                  displayToastWithContext(
                                    TypeMsg.msg,
                                    "Suppression réussie",
                                  );
                                } else {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    "Échec de la suppression",
                                  );
                                }
                              });
                            },
                          );
                        },
                      );
                    },
                    type: ButtonType.danger,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
