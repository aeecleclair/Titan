import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/router.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/admin/ui/components/item_card_ui.dart';
import 'package:myecl/admin/ui/pages/group_page/group_ui.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class GroupsPage extends HookConsumerWidget {
  const GroupsPage({super.key});

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
      orElse: () => [],
    );

    return AdminTemplate(
      child: Refresher(
        onRefresh: () async {
          await groupsNotifier.loadGroups();
          await loanListNotifier.loadLoanerList();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AdminTextConstants.groups,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.gradient1,
                  ),
                ),
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
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              QR.to(
                                AdminRouter.root +
                                    AdminRouter.groups +
                                    AdminRouter.addGroup,
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
                          GestureDetector(
                            onTap: () {
                              QR.to(
                                AdminRouter.root +
                                    AdminRouter.groups +
                                    AdminRouter.addLoaner,
                              );
                            },
                            child: ItemCardUi(
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
                                    ),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          ...g.map(
                            (group) => GroupUi(
                              group: group,
                              isLoaner: loanersId.contains(group.id),
                              onEdit: () {
                                groupIdNotifier.setId(group.id);
                                QR.to(
                                  AdminRouter.root +
                                      AdminRouter.groups +
                                      AdminRouter.editGroup,
                                );
                              },
                              onDelete: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                      title: AdminTextConstants.deleting,
                                      descriptions:
                                          AdminTextConstants.deleteGroup,
                                      onYes: () async {
                                        final value = await groupsNotifier
                                            .deleteGroup(group.id);
                                        if (value) {
                                          displayToastWithContext(
                                            TypeMsg.msg,
                                            AdminTextConstants.deletedGroup,
                                          );
                                        } else {
                                          displayToastWithContext(
                                            TypeMsg.error,
                                            AdminTextConstants.deletingError,
                                          );
                                        }
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
