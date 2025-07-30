import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/group_id_provider.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class GroupsPage extends HookConsumerWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(allGroupListProvider);
    final groupsNotifier = ref.watch(allGroupListProvider.notifier);
    final nameController = useTextEditingController();
    final descController = useTextEditingController();
    final groupIdNotifier = ref.watch(groupIdProvider.notifier);
    final groupListNotifier = ref.watch(allGroupListProvider.notifier);
    final scrollController = useScrollController();
    ref.watch(userList);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdminTemplate(
      child: ScrollToHideNavbar(
        controller: scrollController,
        child: Refresher(
          controller: scrollController,
          onRefresh: () async {
            await groupsNotifier.loadGroups();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Gestion des groupes",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.title,
                      ),
                    ),
                    Spacer(),
                    CustomIconButton(
                      icon: const HeroIcon(
                        HeroIcons.plus,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        nameController.text = '';
                        descController.text = '';
                        await showCustomBottomModal(
                          context: context,
                          ref: ref,
                          modal: BottomModalTemplate(
                            title: "Ajouter un groupe",
                            child: Column(
                              children: [
                                TextEntry(
                                  label: 'Nom',
                                  controller: nameController,
                                ),
                                const SizedBox(height: 20),
                                TextEntry(
                                  label: 'Description',
                                  controller: descController,
                                ),
                                const SizedBox(height: 20),
                                Button(
                                  text: "Ajouter",
                                  onPressed: () async {
                                    final addedGroupMsg = AppLocalizations.of(
                                      context,
                                    )!.adminAddedGroup;
                                    final addingErrorMsg = AppLocalizations.of(
                                      context,
                                    )!.adminAddingError;
                                    await tokenExpireWrapper(ref, () async {
                                      final value = await groupListNotifier
                                          .createGroup(
                                            SimpleGroup(
                                              name: nameController.text,
                                              description: descController.text,
                                              id: '',
                                            ),
                                          );
                                      if (value) {
                                        QR.back();
                                        displayToastWithContext(
                                          TypeMsg.msg,
                                          addedGroupMsg,
                                        );
                                      } else {
                                        displayToastWithContext(
                                          TypeMsg.error,
                                          addingErrorMsg,
                                        );
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                AsyncChild(
                  value: groups,
                  builder: (context, g) {
                    g.sort(
                      (a, b) =>
                          a.name.toLowerCase().compareTo(b.name.toLowerCase()),
                    );
                    return Column(
                      children: [
                        ...g.map(
                          (group) => ListItem(
                            title: group.name,
                            subtitle: group.description,
                            onTap: () async {
                              await showCustomBottomModal(
                                context: context,
                                ref: ref,
                                modal: BottomModalTemplate(
                                  title: group.name,
                                  child: Column(
                                    children: [
                                      Button(
                                        text: "Modifier",
                                        onPressed: () async {
                                          nameController.text = group.name;
                                          descController.text =
                                              group.description;
                                          Navigator.pop(context);
                                          await showCustomBottomModal(
                                            context: context,
                                            ref: ref,
                                            modal: BottomModalTemplate(
                                              title: "Modifier le groupe",
                                              child: Column(
                                                children: [
                                                  TextEntry(
                                                    label: "Nom",
                                                    controller: nameController,
                                                  ),
                                                  const SizedBox(height: 20),
                                                  TextEntry(
                                                    label: "Description",
                                                    controller: descController,
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Button(
                                                    text: "Éditer",
                                                    onPressed: () async {
                                                      final addedGroupMsg =
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.adminAddedGroup;
                                                      final addingErrorMsg =
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.adminAddingError;
                                                      await tokenExpireWrapper(
                                                        ref,
                                                        () async {
                                                          final value = await groupListNotifier
                                                              .updateGroup(
                                                                SimpleGroup(
                                                                  name:
                                                                      nameController
                                                                          .text,
                                                                  description:
                                                                      descController
                                                                          .text,
                                                                  id: group.id,
                                                                ),
                                                              );
                                                          if (value) {
                                                            QR.back();
                                                            displayToastWithContext(
                                                              TypeMsg.msg,
                                                              addedGroupMsg,
                                                            );
                                                          } else {
                                                            displayToastWithContext(
                                                              TypeMsg.error,
                                                              addingErrorMsg,
                                                            );
                                                          }
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      Button(
                                        text: "Gérer les membres",
                                        onPressed: () {
                                          Navigator.pop(context);
                                          groupIdNotifier.setId(group.id);
                                          QR.to(
                                            AdminRouter.root +
                                                AdminRouter.usersGroups +
                                                AdminRouter.editGroup,
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      Button(
                                        text: "Supprimer le groupe",
                                        type: ButtonType.danger,
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CustomDialogBox(
                                                title: "Delete",
                                                descriptions:
                                                    "Êtes-vous sûr de vouloir supprimer ce groupe ?",
                                                onYes: () async {
                                                  tokenExpireWrapper(ref, () async {
                                                    final value =
                                                        await groupsNotifier
                                                            .deleteGroup(group);
                                                    if (value) {
                                                      displayToastWithContext(
                                                        TypeMsg.msg,
                                                        "Groupe supprimé avec succès",
                                                      );
                                                    } else {
                                                      displayToastWithContext(
                                                        TypeMsg.error,
                                                        "Échec de la suppression du groupe",
                                                      );
                                                    }
                                                  });
                                                },
                                              );
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
