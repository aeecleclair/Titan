import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/ui/refresh_indicator.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(allGroupListProvider);
    final groupsNotifier = ref.watch(allGroupListProvider.notifier);
    final pageNotifier = ref.watch(adminPageProvider.notifier);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final groupIdNotifier = ref.watch(groupIdProvider.notifier);
    final loans = ref.watch(loanerList);
    final loanListNotifier = ref.watch(loanerListProvider.notifier);
    ref.watch(userList);
    return AdminRefresher(
      onRefresh: () async {
        await groupsNotifier.loadGroups();
        await loanListNotifier.loadLoanerList();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: groups.when(data: (g) {
          return Column(children: [
            const Text(AdminTextConstants.association + "s",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AdminColorConstants.gradient1)),
            SizedBox(
              height: 10,
              width: MediaQuery.of(context).size.width,
            ),
            ...g
                .map((x) => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          capitalize(x.name),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )),
                    onTap: () async {
                      groupIdNotifier.setId(x.id);
                      tokenExpireWrapper(ref, () async {
                        await groupNotifier.loadGroup(x.id);
                        pageNotifier.setAdminPage(AdminPage.asso);
                      });
                    }))
                .toList(),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient:  LinearGradient(
                    colors: const [
                      AdminColorConstants.gradient1,
                      AdminColorConstants.gradient2,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AdminColorConstants.gradient2.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                      spreadRadius: 2,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  AdminTextConstants.addAssociation,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              onTap: () {
                pageNotifier.setAdminPage(AdminPage.addAsso);
              },
            ),
            loans.isNotEmpty
                ? Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(AdminTextConstants.loaningAssociation,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: AdminColorConstants.gradient1)),
                      const SizedBox(height: 10),
                      ...loans
                          .map((x) => GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    capitalize(x.name),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )),
                              onTap: () {
                                groupIdNotifier.setId(x.groupManagerId);
                                groupNotifier
                                    .loadGroup(x.groupManagerId)
                                    .then((value) {
                                  pageNotifier.setAdminPage(AdminPage.asso);
                                });
                              }))
                          .toList(),
                    ],
                  )
                : Container(),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient:  LinearGradient(
                    colors: const [
                      AdminColorConstants.gradient1,
                      AdminColorConstants.gradient2,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AdminColorConstants.gradient2.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                      spreadRadius: 2,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  AdminTextConstants.addLoaningAssociation,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              onTap: () {
                pageNotifier.setAdminPage(AdminPage.addLoaner);
              },
            )
          ]);
        }, error: (e, s) {
          return Text(e.toString());
        }, loading: () {
          return const Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AdminColorConstants.gradient1),
          ));
        }),
      ),
    );
  }
}
