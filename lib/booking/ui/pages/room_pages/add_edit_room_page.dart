import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/providers/room_provider.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/booking/ui/components/add_edit_button.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditRoomPage extends HookConsumerWidget {
  const AddEditRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  ShrinkButton(
                    builder: (child) => AddEditButton(child: child),
                    onTap: () async {
                      await tokenExpireWrapper(ref, () async {
                        Room newRoom =
                            Room(id: isEdit ? room.id : '', name: name.text);
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
                    child: Text(
                        isEdit
                            ? BookingTextConstants.edit
                            : BookingTextConstants.add,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            )
          ])),
    );
  }
}
