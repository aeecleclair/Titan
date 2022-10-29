import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/booking/ui/pages/admin_page/room_chip.dart';
import 'package:myecl/booking/ui/pages/booking_group_page/checkbox_entry.dart';
import 'package:myecl/booking/ui/pages/booking_group_page/date_entry.dart';
import 'package:myecl/booking/ui/pages/booking_group_page/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AddBookingPage extends HookConsumerWidget {
  const AddBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    final key = GlobalKey<FormState>();
    final rooms = ref.watch(roomListProvider);
    final bookingListNotifier = ref.watch(bookingListProvider.notifier);
    final bookingsNotifier = ref.watch(userBookingListProvider.notifier);
    final room = useState(Room.empty());
    final start = useTextEditingController();
    final end = useTextEditingController();
    final motif = useTextEditingController();
    final note = useTextEditingController();
    final recurring = useState(false);
    final multipleDay = useState(false);
    final keyRequired = useState(false);
    void displayBookingToastWithContext(TypeMsg type, String msg) {
      displayBookingToast(context, type, msg);
    }

    return Expanded(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
              key: key,
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(BookingTextConstants.addBooking,
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold))),
                ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(children: [
                    DateEntry(
                        title: BookingTextConstants.startDate,
                        controller: start),
                    const SizedBox(height: 30),
                    DateEntry(
                        title: BookingTextConstants.endDate, controller: end),
                    const SizedBox(height: 30),
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
                    const SizedBox(height: 30),
                    CheckBoxEntry(
                      title: BookingTextConstants.necessaryKey,
                      valueNotifier: keyRequired,
                    ),
                    const SizedBox(height: 30),
                    CheckBoxEntry(
                      title: BookingTextConstants.recurrent,
                      valueNotifier: recurring,
                    ),
                    const SizedBox(height: 30),
                    CheckBoxEntry(
                      title: BookingTextConstants.multipleDay,
                      valueNotifier: multipleDay,
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        if (key.currentState == null) {
                          return;
                        }
                        if (key.currentState!.validate()) {
                          if (processDateBack(start.text)
                                  .compareTo(processDateBack(end.text)) >=
                              0) {
                            displayBookingToast(context, TypeMsg.error,
                                BookingTextConstants.invalidDates);
                          } else if (room.value.id.isEmpty) {
                            displayBookingToast(context, TypeMsg.error,
                                BookingTextConstants.invalidRoom);
                          } else {
                            tokenExpireWrapper(ref, () async {
                              Booking newBooking = Booking(
                                  id: '',
                                  reason: motif.text,
                                  start: DateTime.parse(processDateBack(start.value.text)),
                                  end: DateTime.parse(processDateBack(end.value.text)),
                                  note: note.text,
                                  room: room.value,
                                  key: keyRequired.value,
                                  decision: Decision.pending,
                                  multipleDay: multipleDay.value,
                                  recurring: recurring.value);
                              final value = await bookingListNotifier
                                  .addBooking(newBooking);
                              if (value) {
                                await bookingsNotifier.addBooking(newBooking);
                                pageNotifier.setBookingPage(BookingPage.main);
                                displayBookingToastWithContext(TypeMsg.msg,
                                    BookingTextConstants.addedBooking);
                              } else {
                                displayBookingToastWithContext(TypeMsg.error,
                                    BookingTextConstants.addingError);
                              }
                            });
                          }
                        } else {
                          displayBookingToast(context, TypeMsg.error,
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
