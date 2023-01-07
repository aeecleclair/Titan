import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/providers/simple_groups_groups_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/user_ui.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class EditPage extends HookConsumerWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupId = ref.watch(groupIdProvider);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final groupListNotifier = ref.watch(allGroupListProvider.notifier);
    ref.watch(userList);
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final description = useTextEditingController();
    final pageNotifier = ref.watch(adminPageProvider.notifier);
    final usersNotifier = ref.watch(userList.notifier);
    final simplegroupsGroupsNotifier =
        ref.watch(simpleGroupsGroupsProvider.notifier);
    final simplegroupsGroups = ref.watch(simpleGroupsGroupsProvider);
    final simplegroupGroupsNotifier =
        ref.watch(simpleGroupsGroupsProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: simplegroupsGroups.when(data: (value) {
              final g = value[groupId];
              if (g == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return g.when(
                data: (g) {
                  if (g.isEmpty) {
                    tokenExpireWrapper(ref, () async {
                      final g = await groupNotifier.loadGroup(groupId);
                      g.whenData((value) {
                        simplegroupsGroupsNotifier.setTData(
                            groupId, AsyncData([value]));
                      });
                    });
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  name.text = g[0].name;
                  description.text = g[0].description;
                  return Column(children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(AdminTextConstants.edit,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.gradient1)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: key,
                      child: Column(children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(bottom: 3),
                                  child: const Text(
                                    AdminTextConstants.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 158, 158, 158),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: TextFormField(
                                    controller: name,
                                    cursorColor: ColorConstants.gradient1,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(10),
                                        isDense: true,
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary)),
                                        focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    ColorConstants.gradient1))),
                                    validator: (value) {
                                      if (value == null) {
                                        return AdminTextConstants
                                            .emptyFieldError;
                                      } else if (value.isEmpty) {
                                        return AdminTextConstants
                                            .emptyFieldError;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(bottom: 3),
                                  child: const Text(
                                    AdminTextConstants.description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 158, 158, 158),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: TextFormField(
                                    controller: description,
                                    cursorColor: ColorConstants.gradient1,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(10),
                                        isDense: true,
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary)),
                                        focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    ColorConstants.gradient1))),
                                    validator: (value) {
                                      if (value == null) {
                                        return AdminTextConstants
                                            .emptyFieldError;
                                      } else if (value.isEmpty) {
                                        return AdminTextConstants
                                            .emptyFieldError;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "${AdminTextConstants.members} :",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.tertiary),
                            ),
                            GestureDetector(
                              onTap: () {
                                usersNotifier.clear();
                                pageNotifier.setAdminPage(AdminPage.addMember);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        ColorConstants.gradient1,
                                        ColorConstants.gradient2
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorConstants.gradient2
                                            .withOpacity(0.4),
                                        offset: const Offset(2, 3),
                                        blurRadius: 5)
                                  ],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: const HeroIcon(
                                  HeroIcons.plus,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ...g[0].members.map((x) => UserUi(
                            user: x,
                            onDelete: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomDialogBox(
                                          descriptions: AdminTextConstants
                                              .removeAssociationMember,
                                          title: AdminTextConstants.deleting,
                                          onYes: () async {
                                            tokenExpireWrapper(ref, () async {
                                              Group newGroup = g[0].copyWith(
                                                  members: g[0]
                                                      .members
                                                      .where((element) =>
                                                          element.id != x.id)
                                                      .toList());
                                              final value = await groupNotifier
                                                  .deleteMember(newGroup, x);
                                              if (value) {
                                                simplegroupGroupsNotifier
                                                    .setTData(newGroup.id,
                                                        AsyncData([newGroup]));
                                                pageNotifier.setAdminPage(
                                                    AdminPage.edit);
                                                displayToastWithContext(
                                                    TypeMsg.msg,
                                                    AdminTextConstants
                                                        .updatedAssociation);
                                              } else {
                                                displayToastWithContext(
                                                    TypeMsg.msg,
                                                    AdminTextConstants
                                                        .updatingError);
                                              }
                                            });
                                          }));
                            })),
                        const SizedBox(
                          height: 20,
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
                                  ColorConstants.gradient1,
                                  ColorConstants.gradient2,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      ColorConstants.gradient2.withOpacity(0.5),
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
                          onTap: () async {
                            tokenExpireWrapper(ref, () async {
                              Group newGroup = g[0].copyWith(
                                  name: name.text,
                                  description: description.text);
                              groupNotifier.setGroup(newGroup);
                              final value = await groupListNotifier
                                  .updateGroup(newGroup.toSimpleGroup());
                              if (value) {
                                pageNotifier.setAdminPage(AdminPage.asso);
                                displayToastWithContext(TypeMsg.msg,
                                    AdminTextConstants.updatedAssociation);
                              } else {
                                displayToastWithContext(TypeMsg.msg,
                                    AdminTextConstants.updatingError);
                              }
                            });
                          },
                        )
                      ]),
                    )
                  ]);
                },
                error: (Object error, StackTrace? stackTrace) {
                  return Text("$error");
                },
                loading: () {
                  return const Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ));
                },
              );
            }, error: (Object error, StackTrace stackTrace) {
              return Text("$error");
            }, loading: () {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ));
            })));
  }
}
