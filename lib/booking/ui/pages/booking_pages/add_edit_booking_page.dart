import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/providers/selected_days_provider.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/booking/ui/components/waiter.dart';
import 'package:myecl/booking/ui/components/add_edit_button.dart';
import 'package:myecl/booking/ui/pages/booking_pages/checkbox_entry.dart';
import 'package:myecl/booking/ui/pages/booking_pages/date_entry.dart';
import 'package:myecl/booking/ui/pages/booking_pages/text_entry.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';
import 'package:myecl/tools/ui/item_chip.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AddEditBookingPage extends HookConsumerWidget {
  final bool isAdmin;

  const AddEditBookingPage({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final user = ref.watch(userProvider);
    final key = GlobalKey<FormState>();
    final rooms = ref.watch(roomListProvider);
    final usersBookingsNotifier = ref.watch(userBookingListProvider.notifier);
    final confirmedBookingListNotifier =
        ref.watch(confirmedBookingListProvider.notifier);
    final bookingsNotifier = ref.watch(bookingListProvider.notifier);
    final bookings = ref.watch(bookingListProvider);
    final booking = ref.watch(bookingProvider);
    final isEdit = booking.id != Booking.empty().id;
    final room = useState(booking.room);
    final recurrent = useState(booking.recurrenceRule != ""
        ? booking.recurrenceRule.contains("BYDAY")
        : false);
    final allDay = useState(booking.start.hour == 0 &&
        booking.end.hour == 23 &&
        booking.start.minute == 0 &&
        booking.end.minute == 59);
    final start = useTextEditingController(
        text: isEdit
            ? recurrent.value
                ? processDateOnlyHour(booking.start)
                : processDateWithHour(booking.start)
            : "");
    final end = useTextEditingController(
        text: isEdit
            ? recurrent.value
                ? processDateOnlyHour(booking.end)
                : processDateWithHour(booking.end)
            : "");
    final motif = useTextEditingController(text: booking.reason);
    final note = useTextEditingController(text: booking.note);
    final entity = useTextEditingController(text: booking.entity);
    final keyRequired = useState(booking.key);
    final selectedDays = ref.watch(selectedDaysProvider);
    final selectedDaysNotifier = ref.watch(selectedDaysProvider.notifier);
    final interval = useTextEditingController(
        text: booking.recurrenceRule != ""
            ? booking.recurrenceRule.split(";INTERVAL=")[1].split(";")[0]
            : "1");
    final recurrenceEndDate = useTextEditingController(
        text: booking.recurrenceRule != ""
            ? processDate(DateTime.parse(
                booking.recurrenceRule.split(";UNTIL=")[1].split(";")[0]))
            : "");
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return BookingTemplate(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
              key: key,
              child: Column(children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          isEdit
                              ? BookingTextConstants.editBooking
                              : BookingTextConstants.addBooking,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 149, 149, 149)))),
                ),
                const SizedBox(height: 20),
                rooms.when(
                    data: (data) => HorizontalListView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 15),
                              ...data.map(
                                (e) {
                                  final selected = room.value.id == e.id;
                                  return ItemChip(
                                    selected: selected,
                                    onTap: () async {
                                      room.value = e;
                                    },
                                    child: Text(
                                      capitalize(e.name),
                                      style: TextStyle(
                                          color: selected
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                        ),
                    error: (Object error, StackTrace? stackTrace) => Center(
                          child: Text("Error : $error"),
                        ),
                    loading: () => const Waiter()),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(children: [
                    TextEntry(
                      keyboardType: TextInputType.text,
                      controller: entity,
                      isInt: false,
                      label: BookingTextConstants.entity,
                      suffix: '',
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
                    TextEntry(
                      keyboardType: TextInputType.text,
                      label: BookingTextConstants.note,
                      suffix: '',
                      isInt: false,
                      controller: note,
                    ),
                    const SizedBox(height: 20),
                    CheckBoxEntry(
                      title: BookingTextConstants.necessaryKey,
                      valueNotifier: keyRequired,
                      onChanged: () {},
                    ),
                    const SizedBox(height: 20),
                    CheckBoxEntry(
                      title: BookingTextConstants.recurrence,
                      valueNotifier: recurrent,
                      onChanged: () {
                        start.text = "";
                        end.text = "";
                        recurrenceEndDate.text = "";
                      },
                    ),
                    const SizedBox(height: 20),
                    CheckBoxEntry(
                      title: BookingTextConstants.allDay,
                      valueNotifier: allDay,
                      onChanged: () {
                        start.text = "";
                        end.text = "";
                        recurrenceEndDate.text = "";
                      },
                    ),
                    const SizedBox(height: 30),
                    recurrent.value
                        ? Column(
                            children: [
                              const Text(BookingTextConstants.recurrenceDays,
                                  style: TextStyle(color: Colors.black)),
                              const SizedBox(height: 10),
                              Column(
                                  children: BookingTextConstants.dayList
                                      .map((e) => GestureDetector(
                                            onTap: () {
                                              selectedDaysNotifier.toggle(
                                                  BookingTextConstants.dayList
                                                      .indexOf(e));
                                            },
                                            behavior: HitTestBehavior.opaque,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  e,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Checkbox(
                                                  checkColor: Colors.white,
                                                  activeColor: Colors.black,
                                                  value: selectedDays[
                                                      BookingTextConstants
                                                          .dayList
                                                          .indexOf(e)],
                                                  onChanged: (value) {
                                                    selectedDaysNotifier.toggle(
                                                        BookingTextConstants
                                                            .dayList
                                                            .indexOf(e));
                                                  },
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList()),
                              const SizedBox(height: 20),
                              const Text(BookingTextConstants.interval,
                                  style: TextStyle(color: Colors.black)),
                              const SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  prefix: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: const Text(
                                        BookingTextConstants.eventEvery,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                  ),
                                  suffix: const Text(BookingTextConstants.weeks,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                  labelText: BookingTextConstants.interval,
                                  labelStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                  floatingLabelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                ),
                                controller: interval,
                                validator: (value) {
                                  if (value == null) {
                                    return BookingTextConstants
                                        .noDescriptionError;
                                  } else if (int.tryParse(value) == null) {
                                    return BookingTextConstants
                                        .invalidIntervalError;
                                  } else if (int.parse(value) < 1) {
                                    return BookingTextConstants
                                        .invalidIntervalError;
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              if (!allDay.value)
                                Column(
                                  children: [
                                    DateEntry(
                                        onTap: () =>
                                            getOnlyHourDate(context, start),
                                        controller: start,
                                        title: BookingTextConstants.startHour),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    DateEntry(
                                      onTap: () =>
                                          getOnlyHourDate(context, end),
                                      controller: end,
                                      title: BookingTextConstants.endHour,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              DateEntry(
                                onTap: () =>
                                    getOnlyDayDate(context, recurrenceEndDate),
                                controller: recurrenceEndDate,
                                title: BookingTextConstants.recurrenceEndDate,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              DateEntry(
                                  onTap: () => allDay.value
                                      ? getOnlyDayDate(context, start)
                                      : getFullDate(context, start),
                                  controller: start,
                                  title: BookingTextConstants.startDate),
                              const SizedBox(
                                height: 30,
                              ),
                              DateEntry(
                                onTap: () => allDay.value
                                    ? getOnlyDayDate(context, end)
                                    : getFullDate(context, end),
                                controller: end,
                                title: BookingTextConstants.endDate,
                              ),
                            ],
                          ),
                    const SizedBox(height: 50),
                    ShrinkButton(
                      builder: (child) => AddEditButton(child: child),
                      onTap: () async {
                        if (key.currentState == null) {
                          return;
                        }
                        if (key.currentState!.validate()) {
                          if (allDay.value) {
                            start.text = "${start.text} 00:00";
                            end.text = "${end.text} 23:59";
                          }
                          if ((end.text.contains("/") &&
                                  processDateBack(start.text).compareTo(
                                          processDateBack(end.text)) >
                                      0) ||
                              (start.text.compareTo(end.text) > 0)) {
                            displayToast(context, TypeMsg.error,
                                BookingTextConstants.invalidDates);
                          } else if (room.value.id.isEmpty) {
                            displayToast(context, TypeMsg.error,
                                BookingTextConstants.invalidRoom);
                          } else if (recurrent.value &&
                              selectedDays
                                  .where((element) => element)
                                  .isEmpty) {
                            displayToast(context, TypeMsg.error,
                                BookingTextConstants.noDaySelected);
                          } else {
                            await tokenExpireWrapper(ref, () async {
                              String recurrenceRule = "";
                              String startString = start.text;
                              if (!startString.contains("/")) {
                                startString =
                                    "${processDate(now)} $startString";
                              }
                              String endString = end.text;
                              if (!endString.contains("/")) {
                                endString = "${processDate(now)} $endString";
                              }
                              if (recurrent.value) {
                                RecurrenceProperties recurrence =
                                    RecurrenceProperties(startDate: now);
                                recurrence.recurrenceType =
                                    RecurrenceType.weekly;
                                recurrence.recurrenceRange =
                                    RecurrenceRange.endDate;
                                recurrence.endDate = DateTime.parse(
                                    processDateBack(recurrenceEndDate.text));
                                recurrence.weekDays = WeekDays.values
                                    .where((element) => selectedDays[
                                        (WeekDays.values.indexOf(element) - 1) %
                                            7])
                                    .toList();
                                recurrence.interval = int.parse(interval.text);
                                recurrenceRule = SfCalendar.generateRRule(
                                    recurrence,
                                    DateTime.parse(
                                        processDateBackWithHour(startString)),
                                    DateTime.parse(
                                        processDateBackWithHour(endString)));
                              }
                              Booking newBooking = Booking(
                                  id: isEdit ? booking.id : "",
                                  reason: motif.text,
                                  start: DateTime.parse(
                                      processDateBackWithHour(startString)),
                                  end: DateTime.parse(
                                      processDateBackWithHour(endString)),
                                  note: note.text,
                                  room: room.value,
                                  key: keyRequired.value,
                                  decision: booking.decision,
                                  recurrenceRule: recurrenceRule,
                                  entity: entity.text,
                                  applicant: user.toApplicant(),
                                  applicantId: user.id);
                              final value = isEdit
                                  ? await bookingsNotifier
                                      .updateBooking(newBooking)
                                  : await bookingsNotifier
                                      .addBooking(newBooking);
                              if (value) {
                                QR.back();
                                if (isEdit) {
                                  if (booking.decision == Decision.approved) {
                                    await confirmedBookingListNotifier
                                        .updateBooking(newBooking);
                                  }
                                  if (!isAdmin) {
                                    await usersBookingsNotifier
                                        .updateBooking(newBooking);
                                  }
                                  displayToastWithContext(TypeMsg.msg,
                                      BookingTextConstants.editedBooking);
                                } else {
                                  if (!isAdmin) {
                                    newBooking = bookings.when(
                                        data: (value) => value.last,
                                        error: (e, s) => Booking.empty(),
                                        loading: () => Booking.empty());
                                    if (newBooking.id != Booking.empty().id) {
                                      await usersBookingsNotifier
                                          .addBooking(newBooking);
                                    }
                                  }
                                  displayToastWithContext(TypeMsg.msg,
                                      BookingTextConstants.addedBooking);
                                }
                              } else {
                                if (isEdit) {
                                  displayToastWithContext(TypeMsg.error,
                                      BookingTextConstants.editionError);
                                } else {
                                  displayToastWithContext(TypeMsg.error,
                                      BookingTextConstants.addingError);
                                }
                              }
                            });
                          }
                        } else {
                          displayToast(context, TypeMsg.error,
                              BookingTextConstants.incorrectOrMissingFields);
                        }
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
                  ]),
                )
              ]))),
    );
  }
}
