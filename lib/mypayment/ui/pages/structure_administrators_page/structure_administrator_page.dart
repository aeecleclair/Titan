import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/admin/ui/admin.dart';
import 'package:titan/admin/ui/components/user_ui.dart';
import 'package:titan/mypayment/providers/selected_structure_provider.dart';
import 'package:titan/mypayment/providers/structure_list_provider.dart';
import 'package:titan/mypayment/ui/pages/structure_administrators_page/results.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/ui/widgets/styled_search_bar.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class StructureAdministratorsPage extends HookConsumerWidget {
  const StructureAdministratorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(userList.notifier);
    final structure = ref.watch(selectedStructureProvider);
    final structureNotifier = ref.watch(selectedStructureProvider.notifier);
    final structureListNotifier = ref.watch(structureListProvider.notifier);
    final add = useState(false);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdminTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const AlignLeftText(
                "Administrateurs de la structure",
                fontSize: 20,
                color: ColorConstants.gradient1,
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  StyledSearchBar(
                    label: "Rechercher un utilisateur",
                    color: ColorConstants.gradient1,
                    padding: const EdgeInsets.all(0),
                    onChanged: (value) async {
                      if (value.isNotEmpty) {
                        await usersNotifier.filterUsers(value);
                      } else {
                        usersNotifier.clear();
                      }
                    },
                    onSuffixIconTap: (focusNode, editingController) {
                      add.value = !add.value;
                      if (!add.value) {
                        editingController.clear();
                        usersNotifier.clear();
                        focusNode.unfocus();
                      } else {
                        focusNode.requestFocus();
                      }
                    },
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              ColorConstants.gradient1,
                              ColorConstants.gradient2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstants.gradient2.withValues(
                                alpha: 0.4,
                              ),
                              offset: const Offset(2, 3),
                              blurRadius: 5,
                            ),
                          ],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: HeroIcon(
                          !add.value ? HeroIcons.plus : HeroIcons.xMark,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  if (add.value) const SizedBox(height: 10),
                  if (add.value) MemberResults(add: add),
                  if (!add.value)
                    ...structure.administrators.map(
                      (x) => UserUi(
                        user: x,
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => CustomDialogBox(
                              descriptions:
                                  "Supprimer ${x.getName()} des administrateurs de la structure ?",
                              title: AdminTextConstants.deleting,
                              onYes: () async {
                                await tokenExpireWrapper(ref, () async {
                                  final success = await structureListNotifier
                                      .removeStructureAdministrator(
                                        structure,
                                        x.id,
                                      );
                                  if (success) {
                                    structureNotifier.setStructure(
                                      structure.copyWith(
                                        administrators: structure.administrators
                                            .where((admin) => admin.id != x.id)
                                            .toList(),
                                      ),
                                    );
                                    displayToastWithContext(
                                      TypeMsg.msg,
                                      "${x.getName()} a été supprimé des administrateurs de la structure",
                                    );
                                  } else {
                                    displayToastWithContext(
                                      TypeMsg.msg,
                                      "Une erreur est survenue",
                                    );
                                  }
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
