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
import 'package:myecl/booking/ui/pages/admin_pages/admin_entry.dart';
import 'package:myecl/booking/ui/pages/admin_pages/admin_shrink_button.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';

class AddEditManagerPage extends HookConsumerWidget {
  const AddEditManagerPage({super.key});

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
                  AdminEntry(
                    name: BookingTextConstants.managerName,
                    nameController: name,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  groupList.when(
                    data: (List<SimpleGroup> data) {
                      return ScrollManagerChips(
                        data: data,
                        groupId: groupId,
                        groupIdNotifier: groupIdNotifier,
                      );
                    },
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
                  AdminShrinkButton(
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
                    buttonText: isEdit
                        ? BookingTextConstants.edit
                        : BookingTextConstants.add,
                  ),
                  if (isEdit) ...[
                    const SizedBox(
                      height: 30,
                    ),
                    AdminShrinkButton(
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
                      buttonText: BookingTextConstants.delete,
                    )
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

class ScrollManagerChips extends SingleChildScrollView {
  final String groupId;
  final GroupIdNotifier groupIdNotifier;
  final List<SimpleGroup> data;
  final dataKey = GlobalKey();
  ScrollManagerChips({
    super.key,
    required this.data,
    required this.groupId,
    required this.groupIdNotifier,
  }) {
    Future(
      () => Scrollable.ensureVisible(
        dataKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        alignment: 0.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const PageStorageKey("group_list"),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 15),
          ...data.map(
            (e) => AdminChip(
              key: groupId == e.id ? dataKey : null,
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
    );
  }
}
