import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/event/ui/pages/event_pages/checkbox_entry.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/providers/event_provider.dart';
import 'package:myecl/event/providers/selected_days_provider.dart';
import 'package:myecl/event/providers/user_event_list_provider.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/event/ui/pages/event_pages/event_type_chip.dart';
import 'package:myecl/event/ui/pages/event_pages/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AddEditEventPage extends HookConsumerWidget {
  const AddEditEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final user = ref.watch(userProvider);
    final event = ref.watch(eventProvider);
    final rooms = ref.watch(roomListProvider);
    final isEdit = event.id != Event.empty().id;
    final page = ref.watch(eventPageProvider);
    final pageNotifier = ref.watch(eventPageProvider.notifier);
    final key = GlobalKey<FormState>();
    final eventListNotifier = ref.watch(eventEventListProvider.notifier);
    final eventType = useState(event.type);
    final name = useTextEditingController(text: event.name);
    final organizer = useTextEditingController(text: event.organizer);
    final location = useTextEditingController(text: event.location);
    final description = useTextEditingController(text: event.description);
    final allDay = useState(event.allDay);
    final roomId = useState(Room.empty().id);
    final isRoom = useState(false);
    final recurrent = useState(event.recurrenceRule != ""
        ? event.recurrenceRule.contains("BYDAY")
        : false);
    final start = useTextEditingController(
        text: recurrent.value
            ? allDay.value
                ? ""
                : processDateOnlyHour(event.start)
            : allDay.value
                ? processDate(event.start)
                : processDateWithHour(event.start));
    final end = useTextEditingController(
        text: recurrent.value
            ? allDay.value
                ? ""
                : processDateOnlyHour(event.end)
            : allDay.value
                ? processDate(event.end)
                : processDateWithHour(event.end));
    final interval = useTextEditingController(
        text: event.recurrenceRule != ""
            ? event.recurrenceRule.split(";INTERVAL=")[1].split(";")[0]
            : "1");
    final recurrenceEndDate = useTextEditingController(
        text: event.recurrenceRule != ""
            ? processDate(DateTime.parse(
                event.recurrenceRule.split(";UNTIL=")[1].split(";")[0]))
            : "");
    final selectedDays = ref.watch(selectedDaysProvider);
    final selectedDaysNotifier = ref.watch(selectedDaysProvider.notifier);
    final id = rooms.when(
        data: (data) => data
            .firstWhere(
              (element) => element.name == event.location,
              orElse: () => Room.empty(),
            )
            .id,
        loading: () => "",
        error: (e, s) => "");
    roomId.value = id;
    isRoom.value = roomId.value != Room.empty().id;

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Expanded(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
              key: key,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          isEdit
                              ? EventTextConstants.editEvent
                              : EventTextConstants.addEvent,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 149, 149, 149)))),
                ),
                const SizedBox(height: 30),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 15),
                      ...CalendarEventType.values.map(
                        (e) => EventTypeChip(
                          label: calendarEventTypeToString(e),
                          selected: eventType.value == e,
                          onTap: () async {
                            eventType.value = e;
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ),
                Column(children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        TextEntry(
                          keyboardType: TextInputType.text,
                          controller: name,
                          isInt: false,
                          label: EventTextConstants.name,
                          suffix: '',
                        ),
                        const SizedBox(height: 30),
                        TextEntry(
                          keyboardType: TextInputType.text,
                          controller: organizer,
                          isInt: false,
                          label: EventTextConstants.organizer,
                          suffix: '',
                        ),
                        const SizedBox(height: 30),
                        CheckBoxEntry(
                            title: EventTextConstants.recurrence,
                            valueNotifier: recurrent,
                            onChanged: () {
                              start.text = "";
                              end.text = "";
                              recurrenceEndDate.text = "";
                            }),
                        const SizedBox(height: 20),
                        CheckBoxEntry(
                            title: EventTextConstants.allDay,
                            valueNotifier: allDay,
                            onChanged: () {
                              start.text = "";
                              end.text = "";
                              recurrenceEndDate.text = "";
                            }),
                        const SizedBox(height: 30),
                        recurrent.value
                            ? Column(
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                          EventTextConstants.recurrenceDays,
                                          style:
                                              TextStyle(color: Colors.black)),
                                      const SizedBox(height: 10),
                                      Column(
                                          children: EventTextConstants.dayList
                                              .map((e) => GestureDetector(
                                                    onTap: () {
                                                      selectedDaysNotifier
                                                          .toggle(
                                                              EventTextConstants
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
                                                          checkColor:
                                                              Colors.white,
                                                          activeColor:
                                                              Colors.black,
                                                          value: selectedDays[
                                                              EventTextConstants
                                                                  .dayList
                                                                  .indexOf(e)],
                                                          onChanged: (value) {
                                                            selectedDaysNotifier
                                                                .toggle(
                                                                    EventTextConstants
                                                                        .dayList
                                                                        .indexOf(
                                                                            e));
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                              .toList()),
                                      const SizedBox(height: 20),
                                      const Text(EventTextConstants.interval,
                                          style:
                                              TextStyle(color: Colors.black)),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          prefix: Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: const Text(
                                                EventTextConstants.eventEvery,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black)),
                                          ),
                                          suffix: const Text(
                                              EventTextConstants.weeks,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                          labelText:
                                              EventTextConstants.interval,
                                          labelStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                          floatingLabelStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0),
                                          ),
                                        ),
                                        controller: interval,
                                        validator: (value) {
                                          if (value == null) {
                                            return EventTextConstants
                                                .noDescriptionError;
                                          } else if (int.tryParse(value) ==
                                              null) {
                                            return EventTextConstants
                                                .invalidIntervalError;
                                          } else if (int.parse(value) < 1) {
                                            return EventTextConstants
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
                                              onTap: () => _selectOnlyHour(
                                                  context, start),
                                              child: SizedBox(
                                                child: AbsorbPointer(
                                                  child: TextFormField(
                                                    controller: start,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText:
                                                          EventTextConstants
                                                              .startHour,
                                                      floatingLabelStyle:
                                                          TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                        return EventTextConstants
                                                            .noDateError;
                                                      }
                                                      return null;
                                                    },
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                          EventTextConstants
                                                              .endHour,
                                                      floatingLabelStyle:
                                                          TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                        return EventTextConstants
                                                            .noDateError;
                                                      }
                                                      return null;
                                                    },
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                labelText: EventTextConstants
                                                    .recurrenceEndDate,
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
                                                  return EventTextConstants
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
                                                EventTextConstants.startDate,
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
                                              return EventTextConstants
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
                                            labelText:
                                                EventTextConstants.endDate,
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
                                              return EventTextConstants
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
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              isRoom.value = true;
                            },
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Chip(
                                  label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Salle",
                                          style: TextStyle(
                                            color: isRoom.value
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ))),
                                  backgroundColor: isRoom.value
                                      ? Colors.black
                                      : Colors.grey.shade200,
                                ))),
                        GestureDetector(
                          onTap: () {
                            isRoom.value = false;
                            roomId.value = "";
                          },
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Chip(
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Autre",
                                      style: TextStyle(
                                        color: isRoom.value
                                            ? Colors.black
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                backgroundColor: isRoom.value
                                    ? Colors.grey.shade200
                                    : Colors.black),
                          ),
                        )
                      ]),
                  const SizedBox(height: 20),
                  isRoom.value
                      ? SizedBox(
                          height: 59,
                          child: rooms.when(
                              data: (rooms) => ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: rooms.length,
                                  itemBuilder: (context, index) {
                                    final selected =
                                        rooms[index].id == roomId.value;
                                    return GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Chip(
                                            label: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(rooms[index].name,
                                                  style: TextStyle(
                                                    color: selected
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ),
                                            backgroundColor: selected
                                                ? Colors.black
                                                : Colors.grey.shade200),
                                      ),
                                      onTap: () {
                                        location.text = rooms[index].name;
                                        roomId.value = rooms[index].id;
                                      },
                                    );
                                  }),
                              error: (e, s) => Text(e.toString()),
                              loading: () => const SizedBox()),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextEntry(
                            keyboardType: TextInputType.text,
                            controller: location,
                            isInt: false,
                            label: EventTextConstants.location,
                            suffix: '',
                          ),
                        ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        TextEntry(
                          keyboardType: TextInputType.text,
                          controller: description,
                          isInt: false,
                          label: EventTextConstants.description,
                          suffix: '',
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
                                  offset: const Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: const Center(
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (key.currentState == null) {
                              return;
                            }
                            if (key.currentState!.validate()) {
                              if (allDay.value) {
                                if (!start.text.contains(" ")) {
                                  start.text = "${start.text} 00:00";
                                }
                                if (!end.text.contains(" ")) {
                                  end.text = "${end.text} 23:59";
                                }
                              }
                              if ((end.text.contains("/") &&
                                      processDateBack(start.text).compareTo(
                                              processDateBack(end.text)) >
                                          0) ||
                                  (start.text.compareTo(end.text) > 0)) {
                                displayToast(context, TypeMsg.error,
                                    EventTextConstants.invalidDates);
                              } else if (recurrent.value &&
                                  selectedDays
                                      .where((element) => element)
                                      .isEmpty) {
                                displayToast(context, TypeMsg.error,
                                    EventTextConstants.noDaySelected);
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
                                    endString =
                                        "${processDate(now)} $endString";
                                  }
                                  if (recurrent.value) {
                                    RecurrenceProperties recurrence =
                                        RecurrenceProperties(startDate: now);
                                    recurrence.recurrenceType =
                                        RecurrenceType.weekly;
                                    recurrence.recurrenceRange =
                                        RecurrenceRange.endDate;
                                    recurrence.endDate = DateTime.parse(
                                        processDateBack(
                                            recurrenceEndDate.text));
                                    recurrence.weekDays = WeekDays.values
                                        .where((element) => selectedDays[
                                            (WeekDays.values.indexOf(element) -
                                                    1) %
                                                7])
                                        .toList();
                                    recurrence.interval =
                                        int.parse(interval.text);
                                    recurrenceRule = SfCalendar.generateRRule(
                                        recurrence,
                                        DateTime.parse(processDateBackWithHour(
                                            startString)),
                                        DateTime.parse(processDateBackWithHour(
                                            endString)));
                                  }
                                  Event newEvent = Event(
                                      id: isEdit ? event.id : "",
                                      description: description.text,
                                      end: DateTime.parse(
                                          processDateBack(endString)),
                                      name: name.text,
                                      organizer: organizer.text,
                                      allDay: allDay.value,
                                      location: location.text,
                                      start: DateTime.parse(
                                          processDateBack(startString)),
                                      type: eventType.value,
                                      recurrenceRule: recurrenceRule,
                                      applicantId: user.id,
                                      applicant: user.toApplicant(),
                                      decision: Decision.pending,
                                      roomId: roomId.value);
                                  final value = isEdit
                                      ? await eventListNotifier
                                          .updateEvent(newEvent)
                                      : await eventListNotifier
                                          .addEvent(newEvent);
                                  if (value) {
                                    if (page ==
                                        EventPage.addEditEventFromMain) {
                                      pageNotifier.setEventPage(EventPage.main);
                                    } else {
                                      pageNotifier
                                          .setEventPage(EventPage.admin);
                                    }
                                    if (isEdit) {
                                      displayToastWithContext(TypeMsg.msg,
                                          EventTextConstants.editedEvent);
                                    } else {
                                      displayToastWithContext(TypeMsg.msg,
                                          EventTextConstants.addedEvent);
                                    }
                                  } else {
                                    if (isEdit) {
                                      displayToastWithContext(TypeMsg.error,
                                          EventTextConstants.editingError);
                                    } else {
                                      displayToastWithContext(TypeMsg.error,
                                          EventTextConstants.addingError);
                                    }
                                  }
                                });
                              }
                            }
                          },
                          child: Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 12),
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
                                      ? EventTextConstants.edit
                                      : EventTextConstants.add,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ]),
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
                primary: Color.fromARGB(255, 10, 153, 172),
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
                primary: Color.fromARGB(255, 10, 153, 172),
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
