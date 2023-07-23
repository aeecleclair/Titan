import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/router.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/admin/ui/pages/main_page/association_ui.dart';
import 'package:myecl/admin/ui/pages/main_page/card_ui.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/loader.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminMainPage extends HookConsumerWidget {
  const AdminMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(allGroupListProvider);
    final groupsNotifier = ref.watch(allGroupListProvider.notifier);
    final groupIdNotifier = ref.watch(groupIdProvider.notifier);
    final loans = ref.watch(loanerListProvider);
    final loanListNotifier = ref.watch(loanerListProvider.notifier);
    ref.watch(userList);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final loanersId = [];

    loans.whenData(
        (value) => loanersId.addAll(value.map((e) => e.groupManagerId)));

    return AdminTemplate(
      child: Refresher(
        onRefresh: () async {
          await groupsNotifier.loadGroups();
          await loanListNotifier.loadLoanerList();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: groups.when(
              data: (g) {
                g.sort((a, b) =>
                    a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                return Column(children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          QR.to(AdminRouter.root +
                              AdminRouter.editModuleVisibility);
                        },
                        child: CardUi(children: [
                          const Spacer(),
                          HeroIcon(
                            HeroIcons.eye,
                            color: Colors.grey.shade700,
                            size: 40,
                          ),
                          const Spacer(),
                        ]),
                      ),
                      GestureDetector(
                        onTap: () {
                          QR.to(AdminRouter.root + AdminRouter.addAssociation);
                        },
                        child: CardUi(children: [
                          HeroIcon(
                            HeroIcons.plus,
                            color: Colors.grey.shade700,
                            size: 40,
                          ),
                        ]),
                      ),
                      GestureDetector(
                        onTap: () {
                          QR.to(AdminRouter.root + AdminRouter.addLoaner);
                        },
                        child: CardUi(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                HeroIcon(
                                  HeroIcons.buildingLibrary,
                                  color: Colors.grey.shade700,
                                  size: 40,
                                ),
                                Positioned(
                                  right: -2,
                                  top: -2,
                                  child: HeroIcon(
                                    HeroIcons.plus,
                                    size: 15,
                                    color: Colors.grey.shade700,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      ...g
                          .map((group) => AssociationUi(
                                group: group,
                                isLoaner: loanersId.contains(group.id),
                                onEdit: () {
                                  groupIdNotifier.setId(group.id);
                                  QR.to(AdminRouter.root +
                                      AdminRouter.editAssociation);
                                },
                                onDelete: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomDialogBox(
                                          title: AdminTextConstants.deleting,
                                          descriptions: AdminTextConstants
                                              .deleteAssociation,
                                          onYes: () async {
                                            tokenExpireWrapper(ref, () async {
                                              final value = await groupsNotifier
                                                  .deleteGroup(group);
                                              if (value) {
                                                displayToastWithContext(
                                                    TypeMsg.msg,
                                                    AdminTextConstants
                                                        .deletedAssociation);
                                              } else {
                                                displayToastWithContext(
                                                    TypeMsg.error,
                                                    AdminTextConstants
                                                        .deletingError);
                                              }
                                            });
                                          },
                                        );
                                      });
                                },
                              ))
                          .toList(),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ]);
              },
              error: (e, s) => Text(e.toString()),
              loading: () => const Loader(color: ColorConstants.gradient1)),
        ),
      ),
    );
  }
}
