import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/ui/pages/main_page/asso_ui.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
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
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final loanersId = loans.map((e) => e.groupManagerId).toList();

    return Refresher(
      onRefresh: () async {
        await groupsNotifier.loadGroups();
        await loanListNotifier.loadLoanerList();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: groups.when(data: (g) {
          return Column(children: [
            //   const Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(AdminTextConstants.association,
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w700,
            //             color: ColorConstants.gradient1)),
            //   ),
            // const SizedBox(
            //   height: 20,
            // ),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: g.length + 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: .7),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return GestureDetector(
                        onTap: () {
                          pageNotifier.setAdminPage(AdminPage.addAsso);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.grey.shade300.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(100)),
                              child: const HeroIcon(
                                HeroIcons.plus,
                                size: 60,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              AdminTextConstants.add,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ));
                  } else if (index == 1) {
                    return GestureDetector(
                        onTap: () {
                          pageNotifier.setAdminPage(AdminPage.addLoaner);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300
                                              .withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(100)),
                                  child: const HeroIcon(
                                    HeroIcons.buildingLibrary,
                                    size: 60,
                                  ),
                                ),
                                const Positioned(
                                  right: 22,
                                  top: 22,
                                  child: HeroIcon(
                                    HeroIcons.plus,
                                    size: 25,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              AdminTextConstants.add,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ));
                  }
                  final group = g[index - 2];
                  return AssoUi(
                    group: group,
                    isLoaner: loanersId.contains(group.id),
                    onTap: () async {
                      groupIdNotifier.setId(group.id);
                      tokenExpireWrapper(ref, () async {
                        await groupNotifier.loadGroup(group.id);
                        pageNotifier.setAdminPage(AdminPage.asso);
                      });
                    },
                    onEdit: () {
                      groupIdNotifier.setId(group.id);
                      tokenExpireWrapper(ref, () async {
                        await groupNotifier.loadGroup(group.id);
                        pageNotifier.setAdminPage(AdminPage.edit);
                      });
                    },
                    onDelete: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialogBox(
                              title: AdminTextConstants.deleting,
                              descriptions:
                                  AdminTextConstants.deleteAssociation,
                              onYes: () async {
                                tokenExpireWrapper(ref, () async {
                                  final value =
                                      await groupsNotifier.deleteGroup(group);
                                  if (value) {
                                    displayToastWithContext(TypeMsg.msg,
                                        AdminTextConstants.deletedAssociation);
                                  } else {
                                    displayToastWithContext(TypeMsg.error,
                                        AdminTextConstants.deletingError);
                                  }
                                });
                              },
                            );
                          });
                    },
                  );
                }),
            // GestureDetector(
            //   child: Container(
            //     width: double.infinity,
            //     margin: const EdgeInsets.symmetric(vertical: 20),
            //     padding: const EdgeInsets.symmetric(vertical: 15),
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //       gradient: const LinearGradient(
            //         colors: [
            //           ColorConstants.gradient1,
            //           ColorConstants.gradient2,
            //         ],
            //       ),
            //       boxShadow: [
            //         BoxShadow(
            //           color: ColorConstants.gradient2.withOpacity(0.5),
            //           blurRadius: 5,
            //           offset: const Offset(2, 2),
            //           spreadRadius: 2,
            //         ),
            //       ],
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     child: const Text(
            //       AdminTextConstants.addAssociation,
            //       style: TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w600,
            //         color: Color.fromARGB(255, 255, 255, 255),
            //       ),
            //     ),
            //   ),
            //   onTap: () {
            //     pageNotifier.setAdminPage(AdminPage.addAsso);
            //   },
            // ),
            // if (loans.isNotEmpty)
            //   Column(
            //     children: [
            //       const SizedBox(
            //         height: 20,
            //       ),
            //       const Text(AdminTextConstants.loaningAssociation,
            //           style: TextStyle(
            //               fontSize: 25,
            //               fontWeight: FontWeight.bold,
            //               color: ColorConstants.gradient1)),
            //       const SizedBox(height: 10),
            //       ...loans
            //           .map((x) => AssoUi(
            //               group: x.,
            //               onTap: () async {
            //                 groupIdNotifier.setId(x.groupManagerId);
            //                 await groupNotifier.loadGroup(x.groupManagerId);
            //                 pageNotifier.setAdminPage(AdminPage.asso);
            //               }))
            //           .toList(),
            //     ],
            //   ),
            // GestureDetector(
            //   child: Container(
            //     width: double.infinity,
            //     margin: const EdgeInsets.symmetric(vertical: 20),
            //     padding: const EdgeInsets.symmetric(vertical: 15),
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //       gradient: const LinearGradient(
            //         colors: [
            //           ColorConstants.gradient1,
            //           ColorConstants.gradient2,
            //         ],
            //       ),
            //       boxShadow: [
            //         BoxShadow(
            //           color: ColorConstants.gradient2.withOpacity(0.5),
            //           blurRadius: 5,
            //           offset: const Offset(2, 2),
            //           spreadRadius: 2,
            //         ),
            //       ],
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     child: const Text(
            //       AdminTextConstants.addLoaningAssociation,
            //       style: TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w600,
            //         color: Color.fromARGB(255, 255, 255, 255),
            //       ),
            //     ),
            //   ),
            //   onTap: () {
            //     pageNotifier.setAdminPage(AdminPage.addLoaner);
            //   },
            // )
          ]);
        }, error: (e, s) {
          return Text(e.toString());
        }, loading: () {
          return const Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(ColorConstants.gradient1),
          ));
        }),
      ),
    );
  }
}
