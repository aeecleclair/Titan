import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/booking/class/manager.dart';
import 'package:myecl/booking/providers/manager_list_provider.dart';
import 'package:myecl/booking/providers/manager_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/booking/ui/pages/admin_pages/admin_chip.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';

class AddEditManagerPage extends HookConsumerWidget {
  const AddEditManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupList = ref.watch(allGroupListProvider);
    final groupId = ref.watch(groupIdProvider);
    final groupIdNotifier = ref.watch(groupIdProvider.notifier);
    final managerListNotifier = ref.watch(managerListProvider.notifier);
    final manager = ref.watch(managerProvider);
    final key = GlobalKey<FormState>();
    final isEdit = !manager.isEmpty();
    final name = useTextEditingController(text: manager.name);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return BookingTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    isEdit
                        ? BookingTextConstants.editManager
                        : BookingTextConstants.addManager,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 149, 149)))),
            Form(
              key: key,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    style: const TextStyle(
                      color: ColorConstants.background2,
                    ),
                    controller: name,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      labelText: BookingTextConstants.managerName,
                      floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  groupList.when(
                    data: (List<SimpleGroup> data) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 15),
                          ...data.map(
                            (e) => AdminChip(
                              label: e.name,
                              selected: groupId == e.id,
                              onTap: () {
                                groupIdNotifier.setId(e.id);
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                    error: (Object error, StackTrace? stackTrace) {
                      return Center(child: Text('Error $error'));
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ShrinkButton(
                    waitChild: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8, bottom: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(3, 3),
                            ),
                          ],
                        ),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        )),
                    onTap: () async {
                      await tokenExpireWrapper(ref, () async {
                        Manager newManager = Manager(
                            id: isEdit ? manager.id : '',
                            name: name.text,
                            groupId: groupId);
                        final value = isEdit
                            ? await managerListNotifier
                                .updateManager(newManager)
                            : await managerListNotifier.addManager(newManager);
                        if (value) {
                          QR.back();
                          isEdit
                              ? displayToastWithContext(TypeMsg.msg,
                                  BookingTextConstants.editedManager)
                              : displayToastWithContext(TypeMsg.msg,
                                  BookingTextConstants.addedManager);
                        } else {
                          isEdit
                              ? displayToastWithContext(TypeMsg.error,
                                  BookingTextConstants.editionError)
                              : displayToastWithContext(TypeMsg.error,
                                  BookingTextConstants.addingError);
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 8, bottom: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        isEdit
                            ? BookingTextConstants.edit
                            : BookingTextConstants.add,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  if (isEdit) ...[
                    const SizedBox(
                      height: 30,
                    ),
                    ShrinkButton(
                      waitChild: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8, bottom: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(3, 3),
                            ),
                          ],
                        ),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async {
                        await tokenExpireWrapper(ref, () async {
                          await showDialog(
                              context: context,
                              builder: (context) => CustomDialogBox(
                                    descriptions: BookingTextConstants
                                        .deleteManagerConfirmation,
                                    onYes: () async {
                                      final value = await managerListNotifier
                                          .deleteManager(manager);
                                      if (value) {
                                        QR.back();
                                        displayToastWithContext(
                                            TypeMsg.msg,
                                            BookingTextConstants
                                                .deletedManager);
                                      } else {
                                        displayToastWithContext(TypeMsg.error,
                                            BookingTextConstants.deletingError);
                                      }
                                    },
                                    title: BookingTextConstants.deleting,
                                  ));
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8, bottom: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(3, 3),
                            ),
                          ],
                        ),
                        child: const Text(
                          BookingTextConstants.delete,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 30),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
