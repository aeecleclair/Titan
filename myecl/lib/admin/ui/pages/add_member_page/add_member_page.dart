import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/refresh_indicator.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AddMemberPage extends HookConsumerWidget {
  const AddMemberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(adminPageProvider.notifier);
    final users = useState(ref.watch(userList));
    final usersNotifier = ref.watch(userList.notifier);
    final editingController = useTextEditingController();
    final focus = useState(false);
    final group = ref.watch(groupProvider);
    final groupNotifier = ref.watch(groupProvider.notifier);
    return AdminRefresher(
        onRefresh: () async {
          users.value = await usersNotifier.filterUsers("");
        },
        child: users.value.when(data: (u) {
          return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  SizedBox(
                    child: Column(children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) {
                            focus.value = true;
                            tokenExpireWrapper(ref, () async {
                              final value = await usersNotifier
                                  .filterUsers(editingController.text);
                                users.value = value;
                            });
                          },
                          controller: editingController,
                          autofocus: focus.value,
                          decoration: const InputDecoration(
                              labelText: "Rechercher",
                              hintText: "Rechercher",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ...u
                          .map((e) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      e.getName(),
                                      style: const TextStyle(fontSize: 13),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            if (!group.value!.members
                                                .contains(e)) {
                                              Group newGroup = group.value!
                                                  .copyWith(
                                                      members:
                                                          group.value!.members +
                                                              [e]);
                                              groupNotifier
                                                  .addMember(newGroup, e)
                                                  .then((value) {
                                                if (value) {
                                                } else {}
                                                pageNotifier.setAdminPage(
                                                    AdminPage.edit);
                                              });
                                            }
                                          },
                                          icon: const Icon(Icons.add))
                                    ],
                                  ),
                                  Container(
                                    width: 15,
                                  ),
                                ],
                              ))
                          .toList(),
                    ]),
                  ),
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
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
                            color:
                                AdminColorConstants.gradient2.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(2, 2),
                            spreadRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "Modifier",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                    onTap: () {
                      pageNotifier.setAdminPage(AdminPage.asso);
                    },
                  )
                ],
              ));
        }, error: (Object error, StackTrace? stackTrace) {
          return const Center(child: Text("Erreur"));
        }, loading: () {
          return const Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AdminColorConstants.gradient1),
          ));
        }));
  }
}
