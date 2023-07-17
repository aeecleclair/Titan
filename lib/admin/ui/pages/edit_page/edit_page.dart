import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/simple_groups_groups_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/admin/ui/components/admin_button.dart';
import 'package:myecl/admin/ui/pages/edit_page/search_user.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EditAssociationPage extends HookConsumerWidget {
  const EditAssociationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupId = ref.watch(groupIdProvider);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final groupListNotifier = ref.watch(allGroupListProvider.notifier);
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final description = useTextEditingController();
    final simpleGroupsGroupsNotifier =
        ref.watch(simpleGroupsGroupsProvider.notifier);
    final simpleGroupsGroups = ref.watch(simpleGroupsGroupsProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdminTemplate(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: simpleGroupsGroups.when(data: (value) {
                final g = value[groupId];
                if (g == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return g.when(
                  data: (groups) {
                    if (groups.isEmpty) {
                      Future.delayed(
                          const Duration(milliseconds: 1),
                          () => simpleGroupsGroupsNotifier.setTData(
                              groupId, const AsyncLoading()));
                      tokenExpireWrapper(ref, () async {
                        final loadedGroup =
                            await groupNotifier.loadGroup(groupId);
                        loadedGroup.whenData((value) {
                          simpleGroupsGroupsNotifier.setTData(
                              groupId, AsyncData([value]));
                        });
                      });
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    name.text = groups[0].name;
                    description.text = groups[0].description;
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
                        height: 20,
                      ),
                      Form(
                        key: key,
                        child: Column(children: [
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: TextFormField(
                                      controller: name,
                                      cursorColor: ColorConstants.gradient1,
                                      decoration: InputDecoration(
                                          labelText: "Name",
                                          labelStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          suffixIcon: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: const HeroIcon(
                                              HeroIcons.pencil,
                                            ),
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ColorConstants
                                                          .gradient1))),
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
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: TextFormField(
                                      controller: description,
                                      cursorColor: ColorConstants.gradient1,
                                      decoration: InputDecoration(
                                          labelText: "Description",
                                          labelStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          suffixIcon: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: const HeroIcon(
                                              HeroIcons.pencil,
                                            ),
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ColorConstants
                                                          .gradient1))),
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
                          ShrinkButton(
                            onTap: () async {
                              if (!key.currentState!.validate()) {
                                return;
                              }
                              await tokenExpireWrapper(ref, () async {
                                Group newGroup = groups[0].copyWith(
                                    name: name.text,
                                    description: description.text);
                                groupNotifier.setGroup(newGroup);
                                final value = await groupListNotifier
                                    .updateGroup(newGroup.toSimpleGroup());
                                if (value) {
                                  QR.back();
                                  displayToastWithContext(TypeMsg.msg,
                                      AdminTextConstants.updatedAssociation);
                                } else {
                                  displayToastWithContext(TypeMsg.msg,
                                      AdminTextConstants.updatingError);
                                }
                              });
                            },
                            builder: (child) => AdminButton(child: child),
                            child: const Text(
                                AdminTextConstants.edit,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SearchUser(),
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
              }))),
    );
  }
}
