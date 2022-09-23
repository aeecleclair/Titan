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
import 'package:myecl/tools/tokenExpireWrapper.dart';

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
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: group.when(data: (g) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: Text(capitalize(g.name),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              g.description.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: Text(g.description,
                              style: const TextStyle(fontSize: 18)),
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                child: const Text("${AdminTextConstants.members} :",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              ...g.members.map((x) => Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(capitalize(x.getName()),
                      style: const TextStyle(fontSize: 15)))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        margin: const EdgeInsets.symmetric(vertical: 20),
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
                        )),
                    onTap: () {
                      pageNotifier.setAdminPage(AdminPage.edit);
                    },
                  ),
                  GestureDetector(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AdminColorConstants.redGradient1,
                              AdminColorConstants.redGradient2,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AdminColorConstants.redGradient2
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
                                    pageNotifier.setAdminPage(AdminPage.main);
                                    displayAdminToastWithContext(TypeMsg.msg,
                                        AdminTextConstants.deletedAssociation);
                                  } else {
                                    displayAdminToastWithContext(TypeMsg.error,
                                        AdminTextConstants.deletingError);
                                  }
                                });
                              }));
                    },
                  ),
                ],
              )
            ],
          );
        }, error: (e, s) {
          return Text(e.toString());
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AdminColorConstants.gradient1),
            ),
          );
        }),
      ),
    );
  }
}
