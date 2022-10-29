import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/tools/functions.dart';
import 'package:myecl/admin/ui/refresh_indicator.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
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
          users.value = await usersNotifier
              .filterUsers("", excludeGroup: [group.value!.toSimpleGroup()]);
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: users.value.when(data: (u) {
              return Column(
                children: [
                  SizedBox(
                    child: Column(children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(AdminTextConstants.addingMember,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AdminColorConstants.gradient1)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        onChanged: (value) {
                          focus.value = true;
                          tokenExpireWrapper(ref, () async {
                            final value = await usersNotifier.filterUsers(
                                editingController.text,
                                excludeGroup: [group.value!.toSimpleGroup()]);
                            users.value = value;
                          });
                        },
                        controller: editingController,
                        autofocus: focus.value,
                        cursorColor: AdminColorConstants.gradient1,
                        decoration: const InputDecoration(
                            labelText: AdminTextConstants.looking,
                            hintText: AdminTextConstants.looking,
                            labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AdminColorConstants.background2),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AdminColorConstants.gradient1,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AdminColorConstants.gradient1,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AdminColorConstants.gradient1,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ...u
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        e.getName(),
                                        style: const TextStyle(fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              if (!group.value!.members
                                                  .contains(e)) {
                                                Group newGroup = group.value!
                                                    .copyWith(
                                                        members: group.value!
                                                                .members +
                                                            [e]);
                                                tokenExpireWrapper(ref,
                                                    () async {
                                                  groupNotifier
                                                      .addMember(newGroup, e)
                                                      .then((value) {
                                                    if (value) {
                                                      pageNotifier.setAdminPage(
                                                          AdminPage.edit);
                                                      displayAdminToast(
                                                          context,
                                                          TypeMsg.msg,
                                                          AdminTextConstants
                                                              .addedMember);
                                                    } else {
                                                      displayAdminToast(
                                                          context,
                                                          TypeMsg.error,
                                                          AdminTextConstants
                                                              .addingError);
                                                    }
                                                  });
                                                });
                                              }
                                            },
                                            icon: const Icon(Icons.add))
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ]),
                  ),
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
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
                        AdminTextConstants.edit,
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
              );
            }, error: (Object error, StackTrace? stackTrace) {
              return Center(child: Text(error.toString()));
            }, loading: () {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(AdminColorConstants.gradient1),
              ));
            })));
  }
}
