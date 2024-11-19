import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/router.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/admin/ui/pages/main_page/card_ui.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminMainPage extends HookConsumerWidget {
  const AdminMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(allGroupListProvider);
    final groupsNotifier = ref.watch(allGroupListProvider.notifier);
    final loanListNotifier = ref.watch(loanerListProvider.notifier);
    ref.watch(userList);

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
              g.sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
              );
              return Column(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          QR.to(
                            AdminRouter.root + AdminRouter.editModuleVisibility,
                          );
                        },
                        child: CardUi(
                          children: [
                            const Spacer(),
                            HeroIcon(
                              HeroIcons.eye,
                              color: Colors.grey.shade700,
                              size: 40,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          QR.to(AdminRouter.root + AdminRouter.groups);
                        },
                        child: CardUi(
                          children: [
                            const Spacer(),
                            HeroIcon(
                              HeroIcons.users,
                              color: Colors.grey.shade700,
                              size: 40,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          QR.to(AdminRouter.root + AdminRouter.schools);
                        },
                        child: CardUi(
                          children: [
                            const Spacer(),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                HeroIcon(
                                  HeroIcons.academicCap,
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
                    ],
                  ),
                ],
              );
            },
            loaderColor: ColorConstants.gradient1,
          ),
        ),
      ),
    );
  }
}
