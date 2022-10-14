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

    return Form(
      key: key,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(
                color: BookingColorConstants.darkBlue,
              ),
              controller: name,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: BookingColorConstants.darkBlue,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: BookingColorConstants.darkBlue, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                color: BookingColorConstants.darkBlue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: BookingColorConstants.darkBlue.withOpacity(0.15),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  BookingTextConstants.add,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            onTap: () {
              tokenExpireWrapper(ref, () async {
                final value = await roomListNotifier
                    .addRoom(Room(name: name.text, id: ''));
                if (value) {
                  pageNotifier.setBookingPage(BookingPage.rooms);
                  displayBookingToastWithContext(
                      TypeMsg.msg, BookingTextConstants.addedRoom);
                } else {
                  displayBookingToastWithContext(
                      TypeMsg.error, BookingTextConstants.addingError);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
