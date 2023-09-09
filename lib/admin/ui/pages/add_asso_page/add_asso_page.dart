import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddAssoPage extends HookConsumerWidget {
  const AddAssoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final description = useTextEditingController();
    final groupListNotifier = ref.watch(allGroupListProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdminTemplate(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Form(
                key: key,
                child: Column(children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(AdminTextConstants.addAssociation,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.gradient1)),
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
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  isDense: true,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorConstants.gradient1))),
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
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  isDense: true,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorConstants.gradient1))),
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
                  ShrinkButton(
                    waitChild: Container(
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
                            color: ColorConstants.gradient2.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(2, 2),
                            spreadRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () async {
                      await tokenExpireWrapper(ref, () async {
                        final value = await groupListNotifier.createGroup(
                            SimpleGroup(
                                name: name.text,
                                description: description.text,
                                id: ''));
                        if (value) {
                          QR.back();
                          displayToastWithContext(
                              TypeMsg.msg, AdminTextConstants.addedAssociation);
                        } else {
                          displayToastWithContext(
                              TypeMsg.error, AdminTextConstants.addingError);
                        }
                      });
                    },
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
                            color: ColorConstants.gradient2.withOpacity(0.5),
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
                  )
                ]),
              ))),
    );
  }
}