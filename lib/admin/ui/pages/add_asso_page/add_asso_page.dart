import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AddAssoPage extends HookConsumerWidget {
  const AddAssoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final description = useTextEditingController();
    final pageNotifier = ref.watch(adminPageProvider.notifier);
    final groupListNotifier = ref.watch(allGroupListProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Form(
              key: key,
              child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AdminTextConstants.addAssociation,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            AdminTextConstants.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            controller: name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                isDense: true,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ))),
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
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            AdminTextConstants.description,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            controller: description,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                isDense: true,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColor))),
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
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(2, 2),
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      AdminTextConstants.add,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    tokenExpireWrapper(ref, () async {
                      final value = await groupListNotifier.createGroup(
                          SimpleGroup(
                              name: name.text,
                              description: description.text,
                              id: ''));
                      if (value) {
                        pageNotifier.setAdminPage(AdminPage.main);
                        displayToastWithContext(
                            TypeMsg.msg, AdminTextConstants.addedAssociation);
                      } else {
                        displayToastWithContext(
                            TypeMsg.error, AdminTextConstants.addingError);
                      }
                    });
                  },
                )
              ]),
            )));
  }
}
