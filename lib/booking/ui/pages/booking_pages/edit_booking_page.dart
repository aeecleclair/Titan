import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/pages/admin_page/room_chip.dart';
import 'package:myecl/booking/ui/pages/booking_pages/checkbox_entry.dart';
import 'package:myecl/booking/ui/pages/booking_pages/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class EditBookingPage extends HookConsumerWidget {
  const EditBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    final key = GlobalKey<FormState>();
    final rooms = ref.watch(roomListProvider);
    final bookingsNotifier = ref.watch(userBookingListProvider.notifier);
    final booking = ref.watch(bookingProvider);
    final room = useState(booking.room);
    final start = useTextEditingController(text: processDate(booking.start));
    final end = useTextEditingController(text: processDate(booking.end));
    final motif = useTextEditingController(text: booking.reason);
    final note = useTextEditingController(text: booking.note);
    final recurring = useState(booking.recurrenceRule);
    final keyRequired = useState(booking.key);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Expanded(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
              key: key,
              child: Column(children: [
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(BookingTextConstants.editBooking,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 205, 205, 205)))),
                ),
                const SizedBox(height: 20),
                rooms.when(
                    data: (data) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 15),
                              ...data.map(
                                (e) => RoomChip(
                                  label: capitalize(e.name),
                                  selected: room.value.id == e.id,
                                  onTap: () async {
                                    room.value = e;
                                  },
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                        ),
                    error: (Object error, StackTrace? stackTrace) => Center(
                          child: Text("Error : $error"),
                        ),
                    loading: () => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        )),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(children: [
                    TextEntry(
                      keyboardType: TextInputType.text,
                      label: BookingTextConstants.note,
                      suffix: '',
                      isInt: false,
                      controller: note,
                    ),
                    const SizedBox(height: 30),
                    TextEntry(
                      keyboardType: TextInputType.text,
                      controller: motif,
                      isInt: false,
                      label: BookingTextConstants.reason,
                      suffix: '',
                    ),
                    const SizedBox(height: 20),
                    CheckBoxEntry(
                      title: BookingTextConstants.necessaryKey,
                      valueNotifier: keyRequired,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        if (key.currentState == null) {
                          return;
                        }
                        if (key.currentState!.validate()) {
                          if (start.text.compareTo(end.text) >= 0) {
                            displayToast(context, TypeMsg.error,
                                BookingTextConstants.invalidDates);
                          } else if (room.value.id.isEmpty) {
                            displayToast(context, TypeMsg.error,
                                BookingTextConstants.invalidRoom);
                          } else {
                            tokenExpireWrapper(ref, () async {
                              Booking newBooking = Booking(
                                  id: booking.id,
                                  reason: motif.text,
                                  start: DateTime.parse(start.text),
                                  end: DateTime.parse(end.text),
                                  note: note.text,
                                  room: room.value,
                                  key: keyRequired.value,
                                  decision: Decision.pending,
                                  recurrenceRule: recurring.value);
                              final value = await bookingsNotifier
                                  .updateBooking(newBooking);
                              if (value) {
                                await bookingsNotifier
                                    .updateBooking(newBooking);
                                pageNotifier.setBookingPage(BookingPage.main);
                                displayToastWithContext(TypeMsg.msg,
                                    BookingTextConstants.editedBooking);
                              } else {
                                displayToastWithContext(TypeMsg.error,
                                    BookingTextConstants.editionError);
                              }
                            });
                          }
                        } else {
                          displayToast(context, TypeMsg.error,
                              BookingTextConstants.incorrectOrMissingFields);
                        }
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
                    ),
                    const SizedBox(height: 30),
                  ]),
                )
              ]))),
    );
  }
}
