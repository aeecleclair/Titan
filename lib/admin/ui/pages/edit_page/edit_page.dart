import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/tools/dialog.dart';
import 'package:myecl/admin/tools/functions.dart';
import 'package:myecl/admin/ui/user_ui.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class EditPage extends HookConsumerWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupProvider);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final nameFocus = useState(false);
    final description = useTextEditingController();
    final descriptionFocus = useState(false);
    final pageNotifier = ref.watch(adminPageProvider.notifier);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: group.when(
        data: (g) {
          name.text = g.name;
          description.text = g.description;
          return Form(
            key: key,
            child: Column(children: [
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                          autofocus: nameFocus.value,
                          controller: name,
                          onChanged: (value) {
                            groupNotifier.setGroup(g.copyWith(name: value));
                            nameFocus.value = true;
                            descriptionFocus.value = false;
                          },
                          validator: (value) {
                            if (value == null) {
                              return AdminTextConstants.emptyFieldError;
                            } else if (value.isEmpty) {
                              return AdminTextConstants.emptyFieldError;
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
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                          autofocus: descriptionFocus.value,
                          controller: description,
                          onChanged: (value) {
                            groupNotifier.setGroup(g.copyWith(name: value));
                            descriptionFocus.value = true;
                            nameFocus.value = false;
                          },
                          validator: (value) {
                            if (value == null) {
                              return AdminTextConstants.emptyFieldError;
                            } else if (value.isEmpty) {
                              return AdminTextConstants.emptyFieldError;
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      AdminTextConstants.members + " :",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        pageNotifier.setAdminPage(AdminPage.addMember);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          gradient:  LinearGradient(
                              colors: const [
                                AdminColorConstants.gradient1,
                                AdminColorConstants.gradient2
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          boxShadow: [
                            BoxShadow(
                                color: AdminColorConstants.gradient2
                                    .withOpacity(0.4),
                                offset: const Offset(2, 3),
                                blurRadius: 5)
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
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
              ),
              const SizedBox(
                height: 20,
              ),
              ...g.members.map((x) => UserUi(
                  user: x,
                  onDelete: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AdminDialog(
                            descriptions:
                                AdminTextConstants.removeAssociationMember,
                            title: AdminTextConstants.deleting,
                            onYes: () async {
                              tokenExpireWrapper(ref, () async {
                                Group newGroup = g.copyWith(
                                    members: g.members
                                        .where((element) => element.id != x.id)
                                        .toList());
                                final value = await groupNotifier.deleteMember(
                                    newGroup, x);
                                if (value) {
                                  pageNotifier.setAdminPage(AdminPage.edit);
                                  displayAdminToast(context, TypeMsg.msg,
                                      AdminTextConstants.updatedAssociation);
                                } else {
                                  displayAdminToast(context, TypeMsg.msg,
                                      AdminTextConstants.updatingError);
                                }
                              });
                            }));
                  })),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
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
            ]),
          );
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
      ),
    );
  }
}
