import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/booking/class/manager.dart';
import 'package:titan/service/class/room.dart';
import 'package:titan/booking/providers/manager_list_provider.dart';
import 'package:titan/booking/providers/manager_id_provider.dart';
import 'package:titan/service/providers/room_list_provider.dart';
import 'package:titan/booking/providers/room_provider.dart';
import 'package:titan/booking/ui/booking.dart';
import 'package:titan/booking/ui/pages/admin_pages/admin_entry.dart';
import 'package:titan/booking/ui/pages/admin_pages/admin_scroll_chips.dart';
import 'package:titan/booking/ui/pages/admin_pages/admin_shrink_button.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AddEditRoomPage extends HookConsumerWidget {
  final dataKey = GlobalKey();
  AddEditRoomPage({super.key});

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
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                isEdit
                    ? AppLocalizations.of(context)!.bookingEditRoom
                    : AppLocalizations.of(context)!.bookingAddRoom,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 149, 149, 149),
                ),
              ),
            ),
            Form(
              key: key,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  AdminEntry(
                    name: AppLocalizations.of(context)!.bookingRoomName,
                    nameController: name,
                  ),
                  const SizedBox(height: 50),
                  managerList.when(
                    data: (List<Manager> data) => AdminScrollChips(
                      data: data,
                      isEdit: isEdit,
                      dataKey: dataKey,
                      pageStorageKeyName: "manager_list",
                      builder: (Manager e) {
                        final selected = managerId == e.id;
                        return ItemChip(
                          key: selected ? dataKey : null,
                          selected: selected,
                          onTap: () {
                            managerIdNotifier.setId(e.id);
                          },
                          child: Text(
                            e.name,
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                    error: (Object error, StackTrace? stackTrace) {
                      return Center(child: Text('Error $error'));
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  const SizedBox(height: 50),
                  AdminShrinkButton(
                    onTap: () async {
                      await tokenExpireWrapper(ref, () async {
                        Room newRoom = Room(
                          id: isEdit ? room.id : '',
                          name: name.text,
                          managerId: managerId,
                        );
                        final value = isEdit
                            ? await roomListNotifier.updateRoom(newRoom)
                            : await roomListNotifier.addRoom(newRoom);
                        if (value) {
                          QR.back();
                          isEdit
                              ? displayToastWithContext(
                                  TypeMsg.msg,
                                  AppLocalizations.of(context)!.bookingEditedRoom,
                                )
                              : displayToastWithContext(
                                  TypeMsg.msg,
                                  AppLocalizations.of(context)!.bookingAddedRoom,
                                );
                        } else {
                          isEdit
                              ? displayToastWithContext(
                                  TypeMsg.error,
                                  AppLocalizations.of(context)!.bookingEditionError,
                                )
                              : displayToastWithContext(
                                  TypeMsg.error,
                                  AppLocalizations.of(context)!.bookingAddingError,
                                );
                        }
                      });
                    },
                    buttonText: isEdit
                        ? AppLocalizations.of(context)!.bookingEdit
                        : AppLocalizations.of(context)!.bookingAdd,
                  ),
                  if (isEdit) ...[
                    const SizedBox(height: 30),
                    AdminShrinkButton(
                      onTap: () async {
                        await tokenExpireWrapper(ref, () async {
                          await showDialog(
                            context: context,
                            builder: (context) => CustomDialogBox(
                              descriptions:
                                  AppLocalizations.of(context)!.bookingDeleteRoomConfirmation,
                              onYes: () async {
                                final value = await roomListNotifier.deleteRoom(
                                  room,
                                );
                                if (value) {
                                  QR.back();
                                  displayToastWithContext(
                                    TypeMsg.msg,
                                    AppLocalizations.of(context)!.bookingDeletedRoom,
                                  );
                                } else {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    AppLocalizations.of(context)!.bookingDeletingError,
                                  );
                                }
                              },
                              title: AppLocalizations.of(context)!.bookingDeleteBooking,
                            ),
                          );
                        });
                      },
                      buttonText: AppLocalizations.of(context)!.bookingDelete,
                    ),
                  ],
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
