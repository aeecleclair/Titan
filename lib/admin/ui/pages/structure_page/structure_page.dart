import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/super_admin/providers/structure_manager_provider.dart';
import 'package:titan/super_admin/providers/structure_provider.dart';
import 'package:titan/super_admin/router.dart';
import 'package:titan/super_admin/ui/admin.dart';
import 'package:titan/super_admin/ui/components/item_card_ui.dart';
import 'package:titan/admin/ui/pages/structure_page/structure_ui.dart';
import 'package:titan/paiement/class/structure.dart';
import 'package:titan/paiement/providers/structure_list_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class StructurePage extends HookConsumerWidget {
  const StructurePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final structures = ref.watch(structureListProvider);
    final structuresNotifier = ref.watch(structureListProvider.notifier);
    final structureNotifier = ref.watch(structureProvider.notifier);
    final structureManagerNotifier = ref.watch(
      structureManagerProvider.notifier,
    );
    ref.watch(userList);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SuperAdminTemplate(
      child: Refresher(
        onRefresh: () async {
          await structuresNotifier.getStructures();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.adminStructures,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: 30),
              AsyncChild(
                value: structures,
                builder: (context, structures) {
                  structures.sort(
                    (a, b) =>
                        a.name.toLowerCase().compareTo(b.name.toLowerCase()),
                  );
                  return Column(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              structureNotifier.setStructure(Structure.empty());
                              structureManagerNotifier.setUser(
                                SimpleUser.empty(),
                              );
                              QR.to(
                                SuperAdminRouter.root +
                                    SuperAdminRouter.structures +
                                    SuperAdminRouter.addEditStructure,
                              );
                            },
                            child: ItemCardUi(
                              children: [
                                const Spacer(),
                                HeroIcon(
                                  HeroIcons.plus,
                                  color: Colors.grey.shade700,
                                  size: 40,
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          ...structures.map(
                            (structure) => StructureUi(
                              group: structure,
                              onEdit: () {
                                structureNotifier.setStructure(structure);
                                structureManagerNotifier.setUser(
                                  structure.managerUser,
                                );
                                QR.to(
                                  SuperAdminRouter.root +
                                      SuperAdminRouter.structures +
                                      SuperAdminRouter.addEditStructure,
                                );
                              },
                              onDelete: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                      title: AppLocalizations.of(
                                        context,
                                      )!.adminDeleting,
                                      descriptions: AppLocalizations.of(
                                        context,
                                      )!.adminDeleteGroup,
                                      onYes: () async {
                                        final deletedGroupMsg =
                                            AppLocalizations.of(
                                              context,
                                            )!.adminDeletedGroup;
                                        final deletingErrorMsg =
                                            AppLocalizations.of(
                                              context,
                                            )!.adminDeletingError;
                                        tokenExpireWrapper(ref, () async {
                                          final value = await structuresNotifier
                                              .deleteStructure(structure);
                                          if (value) {
                                            displayToastWithContext(
                                              TypeMsg.msg,
                                              deletedGroupMsg,
                                            );
                                          } else {
                                            displayToastWithContext(
                                              TypeMsg.error,
                                              deletingErrorMsg,
                                            );
                                          }
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  );
                },
                loaderColor: ColorConstants.gradient1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
