import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/tools/dialog.dart';
import 'package:myecl/admin/tools/functions.dart';
import 'package:myecl/admin/ui/refresh_indicator.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AssoPage extends HookConsumerWidget {
  const AssoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupProvider);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final groupsNotifier = ref.watch(allGroupListProvider.notifier);
    final pageNotifier = ref.watch(adminPageProvider.notifier);
    final groupId = ref.watch(groupIdProvider);
    void displayAdminToastWithContext(TypeMsg type, String msg) {
      displayAdminToast(context, type, msg);
    }

    return AdminRefresher(
      onRefresh: () async {
        await groupNotifier.loadGroup(groupId);
      },
      child: group.when(data: (g) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(capitalize(g.name),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AdminColorConstants.gradient1)),
                ),
                const SizedBox(
                  height: 40,
                ),
                if (g.description.isNotEmpty)
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(g.description,
                        style: const TextStyle(fontSize: 18)),
                  ),
                const SizedBox(height: 40),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text("${AdminTextConstants.members} :",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                ...g.members.map((x) => Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(capitalize(x.getName()),
                        style: const TextStyle(fontSize: 18)))),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20, right: 10),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AdminColorConstants.gradient1,
                                  AdminColorConstants.gradient2,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AdminColorConstants.gradient2
                                      .withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: const Offset(2, 2),
                                  spreadRadius: 2,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const HeroIcon(
                              HeroIcons.pencilSquare,
                              color: Colors.white,
                              size: 30,
                            )),
                        onTap: () {
                          pageNotifier.setAdminPage(AdminPage.edit);
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20, left: 10),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AdminColorConstants.gradient1,
                                  AdminColorConstants.gradient2,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AdminColorConstants.gradient2
                                      .withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: const Offset(2, 2),
                                  spreadRadius: 2,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const HeroIcon(
                              HeroIcons.xMark,
                              color: Colors.white,
                              size: 30,
                            )),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AdminDialog(
                                  descriptions:
                                      AdminTextConstants.deleteAssociation,
                                  title: AdminTextConstants.deleting,
                                  onYes: () async {
                                    tokenExpireWrapper(ref, () async {
                                      final value = await groupsNotifier
                                          .deleteGroup(g.toSimpleGroup());
                                      if (value) {
                                        pageNotifier
                                            .setAdminPage(AdminPage.main);
                                        displayAdminToastWithContext(
                                            TypeMsg.msg,
                                            AdminTextConstants
                                                .deletedAssociation);
                                      } else {
                                        displayAdminToastWithContext(
                                            TypeMsg.error,
                                            AdminTextConstants.deletingError);
                                      }
                                    });
                                  }));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ));
      }, error: (e, s) {
        return Text(e.toString());
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AdminColorConstants.gradient1),
          ),
        );
      }),
    );
  }
}
