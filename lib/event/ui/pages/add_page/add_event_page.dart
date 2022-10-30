import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/booking/ui/pages/booking_group_page/checkbox_entry.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/providers/selected_days_provider.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/event/ui/pages/add_page/loaner_chip.dart';
import 'package:myecl/event/ui/pages/add_page/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AddEventPage extends HookConsumerWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(eventPageProvider.notifier);
    final key = GlobalKey<FormState>();
    final eventListNotifier = ref.watch(eventListProvider.notifier);
    final eventType = useState(CalendarEventType.happyHour);
    final name = useTextEditingController();
    final organizer = useTextEditingController();
    final start = useTextEditingController();
    final end = useTextEditingController();
    final place = useTextEditingController();
    final description = useTextEditingController();
    final allDay = useState(false);
    final recurrent = useState(false);
    final interval = useTextEditingController(text: "1");
    final recurrenceEndDate = useTextEditingController();
    final selectedDays = ref.watch(selectedDaysProvider);
    final selectedDaysNotifier = ref.watch(selectedDaysProvider.notifier);

    void displayEventToastWithContext(TypeMsg type, String msg) {
      displayEventToast(context, type, msg);
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
                      child: Text(EventTextConstants.addEvent,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 205, 205, 205)))),
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
                          label: capitalize(e.name),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(children: [
                    const SizedBox(height: 20),
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
                    ),
                    const SizedBox(height: 20),
                    CheckBoxEntry(
                      title: EventTextConstants.allDay,
                      valueNotifier: allDay,
                    ),
                    const SizedBox(height: 30),
                    recurrent.value
                        ? Column(
                            children: [
                              Column(
                                children: [
                                  const Text(EventTextConstants.recurrenceDays,
                                      style: TextStyle(color: Colors.black)),
                                  const SizedBox(height: 10),
                                  Column(
                                      children: EventTextConstants.dayList
                                          .map((e) => GestureDetector(
                                                onTap: () {
                                                  selectedDaysNotifier.toggle(
                                                      EventTextConstants.dayList
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
                                      style: TextStyle(color: Colors.black)),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      prefix: Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
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
                                      labelText: EventTextConstants.interval,
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
                                        return EventTextConstants
                                            .noDescriptionError;
                                      } else if (int.tryParse(value) == null) {
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
                                          onTap: () =>
                                              _selectOnlyHour(context, start),
                                          child: SizedBox(
                                            child: AbsorbPointer(
                                              child: TextFormField(
                                                controller: start,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: EventTextConstants
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
                                          onTap: () =>
                                              _selectOnlyHour(context, end),
                                          child: SizedBox(
                                            child: AbsorbPointer(
                                              child: TextFormField(
                                                controller: end,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: EventTextConstants
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
                                        labelText: EventTextConstants.startDate,
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
                                          return EventTextConstants.noDateError;
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
                                        labelText: EventTextConstants.startDate,
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
                                          return EventTextConstants.noDateError;
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
                    const SizedBox(height: 30),
                    TextEntry(
                      keyboardType: TextInputType.text,
                      controller: place,
                      isInt: false,
                      label: EventTextConstants.place,
                      suffix: '',
                    ),
                    const SizedBox(height: 30),
                    TextEntry(
                      keyboardType: TextInputType.text,
                      controller: description,
                      isInt: false,
                      label: EventTextConstants.description,
                      suffix: '',
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        if (key.currentState == null) {
                          return;
                        }
                        if (key.currentState!.validate()) {
                          if (start.text == "") {
                            start.text = DateTime.now()
                                .subtract(const Duration(minutes: 1))
                                .toString();
                          }
                          if (end.text == "") {
                            end.text = DateTime.now().toString();
                          }
                          if (start.text.compareTo(end.text) > 0) {
                            displayEventToast(context, TypeMsg.error,
                                EventTextConstants.invalidDates);
                          } else {
                            tokenExpireWrapper(ref, () async {
                              String recurrenceRule = "";
                              if (recurrent.value) {
                                RecurrenceProperties recurrence =
                                    RecurrenceProperties(
                                        startDate: DateTime.now());
                                recurrence.recurrenceType =
                                    RecurrenceType.weekly;
                                recurrence.recurrenceRange =
                                    RecurrenceRange.endDate;
                                recurrence.endDate =
                                    DateTime.parse(recurrenceEndDate.text);
                                recurrence.weekDays = WeekDays.values
                                    .where((element) => selectedDays[
                                        (WeekDays.values.indexOf(element) + 1) %
                                            7])
                                    .toList();
                                recurrence.interval = int.parse(interval.text);
                                recurrenceRule = SfCalendar.generateRRule(
                                    recurrence,
                                    DateTime.parse(start.text),
                                    DateTime.parse(end.text));
                              }
                              Event newEvent = Event(
                                  id: '',
                                  description: description.text,
                                  end: DateTime.parse(end.text),
                                  name: name.text,
                                  organizer: organizer.text,
                                  allDay: allDay.value,
                                  location: place.text,
                                  start: DateTime.parse(start.text),
                                  type: eventType.value,
                                  recurrenceRule: recurrenceRule);
                              final value =
                                  await eventListNotifier.addEvent(newEvent);
                              if (value) {
                                pageNotifier.setEventPage(EventPage.main);
                                displayEventToastWithContext(
                                    TypeMsg.msg, EventTextConstants.addedEvent);
                              } else {
                                displayEventToastWithContext(TypeMsg.error,
                                    EventTextConstants.addingError);
                              }
                            });
                          }
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
                          child: const Text(EventTextConstants.add,
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

  _selectOnlyDayDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(now.year + 1, now.month, now.day));
    dateController.text = DateFormat('yyyy-MM-dd')
        .format(picked ?? now.add(const Duration(hours: 1)));
  }

  _selectOnlyHour(
      BuildContext context, TextEditingController dateController) async {
    final TimeOfDay now = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: now,
    );
    dateController.text = DateFormat('HH:mm')
        .format(DateTimeField.combine(DateTime.now(), picked));
  }

  _selectDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(now.year + 1, now.month, now.day));
    if (picked != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(picked),
      );
      dateController.text = DateFormat('yyyy-MM-dd HH:mm')
          .format(DateTimeField.combine(picked, time));
    } else {
      dateController.text = DateFormat('yyyy-MM-dd HH:mm').format(now);
    }
  }
}
