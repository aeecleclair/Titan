import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myecl/booking/class/manager.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/manager_list_provider.dart';
import 'package:myecl/booking/providers/manager_id_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/providers/room_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/booking/ui/pages/admin_pages/admin_chip.dart';
import 'package:myecl/booking/ui/pages/admin_pages/admin_entry.dart';
import 'package:myecl/booking/ui/pages/admin_pages/admin_shrink_button.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditRoomPage extends HookConsumerWidget {
  const AddEditRoomPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final managerList = ref.watch(managerListProvider);
    final managerId = ref.watch(managerIdProvider);
    final managerIdNotifier = ref.watch(managerIdProvider.notifier);
    final roomListNotifier = ref.watch(roomListProvider.notifier);
    final key = GlobalKey<FormState>();
    final room = ref.watch(roomProvider);
    final isEdit = room.id != Room.empty().id;
    final name = useTextEditingController(text: room.name);
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
                        ? BookingTextConstants.editRoom
                        : BookingTextConstants.addRoom,
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
                    name: BookingTextConstants.roomName,
                    nameController: name,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  managerList.when(
                    data: (List<Manager> data) => ScrollManagerChips(
                      data: data,
                      managerId: managerId,
                      managerIdNotifier: managerIdNotifier,
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
                  AdminShrinkButton(
                    onTap: () async {
                      await tokenExpireWrapper(
                        ref,
                        () async {
                          Room newRoom = Room(
                              id: isEdit ? room.id : '',
                              name: name.text,
                              managerId: managerId);
                          final value = isEdit
                              ? await roomListNotifier.updateRoom(newRoom)
                              : await roomListNotifier.addRoom(newRoom);
                          if (value) {
                            QR.back();
                            isEdit
                                ? displayToastWithContext(TypeMsg.msg,
                                    BookingTextConstants.editedRoom)
                                : displayToastWithContext(TypeMsg.msg,
                                    BookingTextConstants.addedRoom);
                          } else {
                            isEdit
                                ? displayToastWithContext(TypeMsg.error,
                                    BookingTextConstants.editionError)
                                : displayToastWithContext(TypeMsg.error,
                                    BookingTextConstants.addingError);
                          }
                        },
                      );
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
                                        .deleteRoomConfirmation,
                                    onYes: () async {
                                      final value = await roomListNotifier
                                          .deleteRoom(room);
                                      if (value) {
                                        QR.back();
                                        displayToastWithContext(TypeMsg.msg,
                                            BookingTextConstants.deletedRoom);
                                      } else {
                                        displayToastWithContext(TypeMsg.error,
                                            BookingTextConstants.deletingError);
                                      }
                                    },
                                    title: BookingTextConstants.deleteBooking,
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
  final String managerId;
  final ManagerIdNotifier managerIdNotifier;
  final List<Manager> data;
  final dataKey = GlobalKey();
  ScrollManagerChips({
    super.key,
    required this.data,
    required this.managerId,
    required this.managerIdNotifier,
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
      key: const PageStorageKey("manager_list"),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 15),
          ...data.map(
            (e) => AdminChip(
              key: managerId == e.id ? dataKey : null,
              label: e.name,
              selected: managerId == e.id,
              onTap: () {
                managerIdNotifier.setId(e.id);
              },
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
