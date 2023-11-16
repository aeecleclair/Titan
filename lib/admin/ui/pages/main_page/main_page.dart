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
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
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

    final List<String> loanersId = loans.maybeWhen(
        data: (value) => value.map((e) => e.groupManagerId).toList(),
        orElse: () => []);

    return AdminTemplate(
      child: Refresher(
        onRefresh: () async {
          await groupsNotifier.loadGroups();
          await loanListNotifier.loadLoanerList();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: AsyncChild(
              value: groups,
              builder: (context, g) {
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
                          const Spacer(),
                          HeroIcon(
                            HeroIcons.plus,
                            color: Colors.grey.shade700,
                            size: 40,
                          ),
                          const Spacer(),
                        ]),
                      ),
                      GestureDetector(
                        onTap: () {
                          QR.to(AdminRouter.root + AdminRouter.addLoaner);
                        },
                        child: CardUi(
                          children: [
                            const Spacer(),
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
                            const Spacer(),
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
                      const SizedBox(height: 20)
                    ],
                  ),
                ]);
              },
              loaderColor: ColorConstants.gradient1),
        ),
      ),
    );
  }
}
