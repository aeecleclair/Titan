import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/service/providers/room_list_provider.dart';
import 'package:titan/event/ui/event.dart';
import 'package:titan/event/ui/pages/event_pages/checkbox_entry.dart';
import 'package:titan/event/class/event.dart';
import 'package:titan/event/providers/event_provider.dart';
import 'package:titan/event/providers/selected_days_provider.dart';
import 'package:titan/event/providers/user_event_list_provider.dart';
import 'package:titan/event/tools/constants.dart';
import 'package:titan/event/tools/functions.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AddEditEventPage extends HookConsumerWidget {
  final eventTypeScrollKey = GlobalKey();
  final eventRoomScrollKey = GlobalKey();
  AddEditEventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final user = ref.watch(userProvider);
    final event = ref.watch(eventProvider);
    final eventNotifier = ref.watch(eventProvider.notifier);
    final rooms = ref.watch(roomListProvider);
    final isEdit = event.id != Event.empty().id;
    final key = GlobalKey<FormState>();
    final eventListNotifier = ref.watch(eventEventListProvider.notifier);
    final eventType = useState(event.type);
    final name = useTextEditingController(text: event.name);
    final organizer = useTextEditingController(text: event.organizer);
    final description = useTextEditingController(text: event.description);
    final allDay = useState(event.allDay);
    final isRoom = useState(false);
    final location = useTextEditingController(text: event.location);

    final recurrent = useState(
      event.recurrenceRule != ""
          ? event.recurrenceRule.contains("BYDAY")
          : false,
    );
    final start = useTextEditingController(
      text: isEdit
          ? recurrent.value
                ? allDay.value
                      ? ""
                      : processDateOnlyHour(event.start)
                : allDay.value
                ? processDate(event.start)
                : processDateWithHour(event.start)
          : "",
    );
    final end = useTextEditingController(
      text: isEdit
          ? recurrent.value
                ? allDay.value
                      ? ""
                      : processDateOnlyHour(event.end)
                : allDay.value
                ? processDate(event.end)
                : processDateWithHour(event.end)
          : "",
    );
    final interval = useTextEditingController(
      text: event.recurrenceRule != ""
          ? event.recurrenceRule.split(";INTERVAL=")[1].split(";")[0]
          : "1",
    );
    final recurrenceEndDate = useTextEditingController(
      text: event.recurrenceRule != ""
          ? processDate(
              DateTime.parse(
                event.recurrenceRule.split(";UNTIL=")[1].split(";")[0],
              ),
            )
          : "",
    );
    final selectedDays = ref.watch(selectedDaysProvider);
    final selectedDaysNotifier = ref.watch(selectedDaysProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return EventTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: key,
          child: Column(
            children: [
              const SizedBox(height: 40),
              AlignLeftText(
                isEdit
                    ? EventTextConstants.editEvent
                    : EventTextConstants.addEvent,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                color: Colors.grey,
              ),
              const SizedBox(height: 30),
              HorizontalListView.builder(
                key: eventTypeScrollKey,
                height: 40,
                items: CalendarEventType.values,
                itemBuilder: (context, value, index) {
                  final selected = eventType.value == value;
                  return ItemChip(
                    selected: selected,
                    onTap: () async {
                      eventType.value = value;
                    },
                    child: Text(
                      calendarEventTypeToString(value),
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        TextEntry(
                          controller: name,
                          label: EventTextConstants.name,
                        ),
                        const SizedBox(height: 30),
                        TextEntry(
                          controller: organizer,
                          label: EventTextConstants.organizer,
                        ),
                        const SizedBox(height: 30),
                        CheckBoxEntry(
                          title: EventTextConstants.recurrence,
                          valueNotifier: recurrent,
                          onChanged: () {
                            start.text = "";
                            end.text = "";
                            recurrenceEndDate.text = "";
                          },
                        ),
                        const SizedBox(height: 20),
                        CheckBoxEntry(
                          title: EventTextConstants.allDay,
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
                                        EventTextConstants.recurrenceDays,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      const SizedBox(height: 10),
                                      Column(
                                        children: EventTextConstants.dayList
                                            .map(
                                              (e) => GestureDetector(
                                                onTap: () {
                                                  selectedDaysNotifier.toggle(
                                                    EventTextConstants.dayList
                                                        .indexOf(e),
                                                  );
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
                                                            .grey
                                                            .shade700,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Checkbox(
                                                      checkColor: Colors.white,
                                                      activeColor: Colors.black,
                                                      value:
                                                          selectedDays[EventTextConstants
                                                              .dayList
                                                              .indexOf(e)],
                                                      onChanged: (value) {
                                                        selectedDaysNotifier
                                                            .toggle(
                                                              EventTextConstants
                                                                  .dayList
                                                                  .indexOf(e),
                                                            );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        EventTextConstants.interval,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      const SizedBox(height: 10),
                                      TextEntry(
                                        label: EventTextConstants.interval,
                                        controller: interval,
                                        prefix: EventTextConstants.eventEvery,
                                        suffix: EventTextConstants.weeks,
                                        isInt: true,
                                        keyboardType: TextInputType.number,
                                      ),
                                      const SizedBox(height: 30),
                                      if (!allDay.value)
                                        Column(
                                          children: [
                                            DateEntry(
                                              onTap: () => getOnlyHourDate(
                                                context,
                                                start,
                                              ),
                                              controller: start,
                                              label:
                                                  EventTextConstants.startHour,
                                            ),
                                            const SizedBox(height: 30),
                                            DateEntry(
                                              onTap: () =>
                                                  getOnlyHourDate(context, end),
                                              controller: end,
                                              label: EventTextConstants.endHour,
                                            ),
                                            const SizedBox(height: 30),
                                          ],
                                        ),
                                      DateEntry(
                                        onTap: () => getOnlyDayDate(
                                          context,
                                          recurrenceEndDate,
                                        ),
                                        controller: recurrenceEndDate,
                                        label: EventTextConstants
                                            .recurrenceEndDate,
                                      ),
                                    ],
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
                                    label: EventTextConstants.startDate,
                                  ),
                                  const SizedBox(height: 30),
                                  DateEntry(
                                    onTap: () => allDay.value
                                        ? getOnlyDayDate(context, end)
                                        : getFullDate(context, end),
                                    controller: end,
                                    label: EventTextConstants.endDate,
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
                      ItemChip(
                        onTap: () {
                          isRoom.value = true;
                        },
                        selected: isRoom.value,
                        child: Text(
                          EventTextConstants.room,
                          style: TextStyle(
                            color: isRoom.value ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ItemChip(
                        onTap: () {
                          isRoom.value = false;
                        },
                        selected: !isRoom.value,
                        child: Text(
                          EventTextConstants.other,
                          style: TextStyle(
                            color: isRoom.value ? Colors.black : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  isRoom.value
                      ? SizedBox(
                          height: 59,
                          child: AsyncChild(
                            value: rooms,
                            builder: (context, rooms) =>
                                HorizontalListView.builder(
                                  key: eventRoomScrollKey,
                                  height: 40,
                                  items: rooms,
                                  itemBuilder: (context, room, index) {
                                    final selected =
                                        room.name == event.location;
                                    return ItemChip(
                                      onTap: () {
                                        eventNotifier.setRoom(room.name);
                                        location.text = room.name;
                                      },
                                      selected: selected,
                                      child: Text(
                                        room.name,
                                        style: TextStyle(
                                          color: selected
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextEntry(
                            controller: location,
                            label: EventTextConstants.location,
                          ),
                        ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        TextEntry(
                          controller: description,
                          label: EventTextConstants.description,
                          keyboardType: TextInputType.multiline,
                        ),
                        const SizedBox(height: 50),
                        WaitingButton(
                          builder: (child) => AddEditButtonLayout(child: child),
                          onTap: () async {
                            if (key.currentState == null) {
                              return;
                            }
                            if (key.currentState!.validate()) {
                              if (allDay.value) {
                                start.text =
                                    "${!recurrent.value ? "${start.text} " : ""}00:00";
                                end.text =
                                    "${!recurrent.value ? "${end.text} " : ""}23:59";
                              }
                              if (end.text.contains("/") &&
                                  isDateBefore(
                                    processDateBack(end.text),
                                    processDateBack(start.text),
                                  )) {
                                displayToast(
                                  context,
                                  TypeMsg.error,
                                  EventTextConstants.invalidDates,
                                );
                              } else if (recurrent.value &&
                                  selectedDays
                                      .where((element) => element)
                                      .isEmpty) {
                                displayToast(
                                  context,
                                  TypeMsg.error,
                                  EventTextConstants.noDaySelected,
                                );
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
                                      processDateBack(recurrenceEndDate.text),
                                    );
                                    recurrence.weekDays = WeekDays.values
                                        .where(
                                          (element) =>
                                              selectedDays[(WeekDays.values
                                                          .indexOf(element) -
                                                      1) %
                                                  7],
                                        )
                                        .toList();
                                    recurrence.interval = int.parse(
                                      interval.text,
                                    );
                                    recurrenceRule = SfCalendar.generateRRule(
                                      recurrence,
                                      DateTime.parse(
                                        processDateBackWithHour(startString),
                                      ),
                                      DateTime.parse(
                                        processDateBackWithHour(endString),
                                      ),
                                    );
                                  }
                                  Event newEvent = Event(
                                    id: isEdit ? event.id : "",
                                    description: description.text,
                                    end: DateTime.parse(
                                      processDateBack(endString),
                                    ),
                                    name: name.text,
                                    organizer: organizer.text,
                                    allDay: allDay.value,
                                    location: location.text,
                                    start: DateTime.parse(
                                      processDateBack(startString),
                                    ),
                                    type: eventType.value,
                                    recurrenceRule: recurrenceRule,
                                    applicantId: user.id,
                                    applicant: user.toApplicant(),
                                    decision: Decision.pending,
                                  );
                                  final value = isEdit
                                      ? await eventListNotifier.updateEvent(
                                          newEvent,
                                        )
                                      : await eventListNotifier.addEvent(
                                          newEvent,
                                        );
                                  if (value) {
                                    QR.back();
                                    if (isEdit) {
                                      displayToastWithContext(
                                        TypeMsg.msg,
                                        EventTextConstants.editedEvent,
                                      );
                                    } else {
                                      displayToastWithContext(
                                        TypeMsg.msg,
                                        EventTextConstants.addedEvent,
                                      );
                                    }
                                  } else {
                                    if (isEdit) {
                                      displayToastWithContext(
                                        TypeMsg.error,
                                        EventTextConstants.editingError,
                                      );
                                    } else {
                                      displayToastWithContext(
                                        TypeMsg.error,
                                        EventTextConstants.addingError,
                                      );
                                    }
                                  }
                                });
                              }
                            }
                          },
                          child: Text(
                            isEdit
                                ? EventTextConstants.edit
                                : EventTextConstants.add,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
