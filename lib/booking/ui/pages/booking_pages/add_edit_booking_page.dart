import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/providers/selected_days_provider.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/booking/ui/pages/admin_pages/admin_chip.dart';
import 'package:myecl/booking/ui/pages/booking_pages/checkbox_entry.dart';
import 'package:myecl/booking/ui/pages/booking_pages/text_entry.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
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
        ref.watch(confirmedBookingListProvider(isAdmin).notifier);
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
                    data: (data) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 15),
                              ...data.map(
                                (e) => AdminChip(
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
                          child: CircularProgressIndicator(),
                        )),
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
                      required: false,
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
                              Column(
                                children: [
                                  const Text(
                                      BookingTextConstants.recurrenceDays,
                                      style: TextStyle(color: Colors.black)),
                                  const SizedBox(height: 10),
                                  Column(
                                      children: BookingTextConstants.dayList
                                          .map((e) => GestureDetector(
                                                onTap: () {
                                                  selectedDaysNotifier.toggle(
                                                      BookingTextConstants
                                                          .dayList
                                                          .indexOf(e));
                                                },
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      e,
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700,
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
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: const Text(
                                            BookingTextConstants.eventEvery,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black)),
                                      ),
                                      suffix: const Text(
                                          BookingTextConstants.weeks,
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
                                        GestureDetector(
                                          onTap: () =>
                                              _selectOnlyHour(context, start),
                                          child: SizedBox(
                                            child: AbsorbPointer(
                                              child: TextFormField(
                                                controller: start,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText:
                                                      BookingTextConstants
                                                          .startHour,
                                                  floatingLabelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 2.0),
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return BookingTextConstants
                                                        .noDateError;
                                                  }
                                                  return null;
                                                },
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              _selectOnlyHour(context, end),
                                          child: SizedBox(
                                            child: AbsorbPointer(
                                              child: TextFormField(
                                                controller: end,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText:
                                                      BookingTextConstants
                                                          .endHour,
                                                  floatingLabelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 2.0),
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return BookingTextConstants
                                                        .noDateError;
                                                  }
                                                  return null;
                                                },
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  GestureDetector(
                                    onTap: () => _selectOnlyDayDate(
                                        context, recurrenceEndDate),
                                    child: SizedBox(
                                      child: AbsorbPointer(
                                        child: TextFormField(
                                          controller: recurrenceEndDate,
                                          decoration: const InputDecoration(
                                            labelText: BookingTextConstants
                                                .recurrenceEndDate,
                                            floatingLabelStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return BookingTextConstants
                                                  .noDateError;
                                            }
                                            return null;
                                          },
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              GestureDetector(
                                onTap: () => allDay.value
                                    ? _selectOnlyDayDate(context, start)
                                    : _selectDate(context, start),
                                child: SizedBox(
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: start,
                                      decoration: const InputDecoration(
                                        labelText:
                                            BookingTextConstants.startDate,
                                        floatingLabelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 2.0),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return BookingTextConstants
                                              .noDateError;
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () => allDay.value
                                    ? _selectOnlyDayDate(context, end)
                                    : _selectDate(context, end),
                                child: SizedBox(
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: end,
                                      decoration: const InputDecoration(
                                        labelText: BookingTextConstants.endDate,
                                        floatingLabelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 2.0),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return BookingTextConstants
                                              .noDateError;
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 50),
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
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                          ))),
                      onTap: () async {
                        if (key.currentState == null) {
                          return;
                        }
                        if (key.currentState!.validate()) {
                          if (allDay.value) {
                            start.text = "${start.text} 00:00";
                            end.text = "${end.text} 23:59";
                          }
                          if (end.text.contains("/") &&
                              isDateBefore(processDateBack(end.text),
                                  processDateBack(start.text))) {
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
                                  creation: DateTime.now(),
                                  note: note.text.isEmpty ? null : note.text,
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
                  ]),
                )
              ]))),
    );
  }

  _selectOnlyDayDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        locale: const Locale("fr", "FR"),
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(now.year + 1, now.month, now.day),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 172, 32, 10),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });
    dateController.text = DateFormat('dd/MM/yyyy')
        .format(picked ?? now.add(const Duration(hours: 1)));
  }

  _selectOnlyHour(
      BuildContext context, TextEditingController dateController) async {
    final TimeOfDay now = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: now,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: ColorConstants.gradient1,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });
    dateController.text = DateFormat('HH:mm')
        .format(DateTimeField.combine(DateTime.now(), picked));
  }

  _selectDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime now = DateTime.now();
    showDatePicker(
        locale: const Locale("fr", "FR"),
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(now.year + 1, now.month, now.day),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 10, 153, 172),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        }).then((picked) {
      if (picked != null) {
        showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color.fromARGB(255, 10, 153, 172),
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black,
                  ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: child!,
              );
            }).then((value) {
          dateController.text = DateFormat('dd/MM/yyyy HH:mm')
              .format(DateTimeField.combine(picked, value));
        });
      } else {
        dateController.text = DateFormat('dd/MM/yyyy HH:mm').format(now);
      }
    });
  }
}
