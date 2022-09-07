import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class AddAssoPage extends HookConsumerWidget {
  const AddAssoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final description = useTextEditingController();
    final pageNotifier = ref.watch(adminPageProvider.notifier);
    final groupListNotifier = ref.watch(allGroupListProvider.notifier);
    return Form(
      key: key,
      child: Column(children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
            width: MediaQuery.of(context).size.width * 0.5,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
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
              AdminTextConstants.add,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          onTap: () async {
            tokenExpireWrapper(ref, () async {
              final value = await groupListNotifier.createGroup(SimpleGroup(
                  name: name.text, description: description.text, id: ''));
              if (value) {
                pageNotifier.setAdminPage(AdminPage.main);
                displayAdminToast(
                    context, TypeMsg.msg, AdminTextConstants.addedAssociation);
              } else {
                displayAdminToast(
                    context, TypeMsg.error, AdminTextConstants.addingError);
              }
            });
          },
        )
      ]),
    );
  }
}
