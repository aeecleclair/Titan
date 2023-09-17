import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myecl/booking/class/manager.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/manager_list_provider.dart';
import 'package:myecl/booking/providers/manager_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/providers/room_provider.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/booking/ui/pages/room_pages/manager_chip.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditRoomPage extends HookConsumerWidget {
  const AddEditRoomPage({Key? key}) : super(key: key);

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
          child: Column(children: [
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
                  TextField(
                    style: const TextStyle(
                      color: ColorConstants.background2,
                    ),
                    controller: name,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      labelText: BookingTextConstants.roomName,
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      BookingTextConstants.managers,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 149, 149),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  managerList.when(
                    data: (List<Manager> data) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 15),
                          ...data.map(
                            (e) => ManagerChip(
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
                        Room newRoom = Room(
                            id: isEdit ? room.id : '',
                            name: name.text,
                            managerId: managerId);
                        final value = isEdit
                            ? await roomListNotifier.updateRoom(newRoom)
                            : await roomListNotifier.addRoom(newRoom);
                        if (value) {
                          QR.to(BookingRouter.root + BookingRouter.admin);
                          isEdit
                              ? displayToastWithContext(
                                  TypeMsg.msg, BookingTextConstants.editedRoom)
                              : displayToastWithContext(
                                  TypeMsg.msg, BookingTextConstants.addedRoom);
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
                                fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            )
          ])),
    );
  }
}
