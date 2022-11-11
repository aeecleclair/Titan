import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AddRoomPage extends HookConsumerWidget {
  const AddRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomListNotifier = ref.watch(roomListProvider.notifier);
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    void displayBookingToastWithContext(TypeMsg type, String msg) {
      displayBookingToast(context, type, msg);
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(BookingTextConstants.addRoom,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 205, 205, 205)))),
          Form(
            key: key,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  style: const TextStyle(
                    color: BookingColorConstants.darkBlue,
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
                GestureDetector(
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
                            offset: const Offset(
                                3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Text(BookingTextConstants.add,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold))),
                  onTap: () {
                    tokenExpireWrapper(ref, () async {
                      final value = await roomListNotifier
                          .addRoom(Room(name: name.text, id: ''));
                      if (value) {
                        pageNotifier.setBookingPage(BookingPage.admin);
                        displayBookingToastWithContext(
                            TypeMsg.msg, BookingTextConstants.addedRoom);
                      } else {
                        displayBookingToastWithContext(
                            TypeMsg.error, BookingTextConstants.addingError);
                      }
                    });
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          )
        ]));
  }
}
