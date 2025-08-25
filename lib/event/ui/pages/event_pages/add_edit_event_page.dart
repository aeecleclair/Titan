import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
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
import 'package:titan/l10n/app_localizations.dart';

class AddEditEventPage extends HookConsumerWidget {
  final eventTypeScrollKey = GlobalKey();
  final eventRoomScrollKey = GlobalKey();
  AddEditEventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
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
                ? DateFormat.yMd(locale).format(event.start)
                : DateFormat.yMd(locale).add_Hm().format(event.start)
          : "",
    );
    final end = useTextEditingController(
      text: isEdit
          ? recurrent.value
                ? allDay.value
                      ? ""
                      : processDateOnlyHour(event.end)
                : allDay.value
                ? DateFormat.yMd(locale).format(event.end)
                : DateFormat.yMd(locale).add_Hm().format(event.end)
          : "",
    );
    final interval = useTextEditingController(
      text: event.recurrenceRule != ""
          ? event.recurrenceRule.split(";INTERVAL=")[1].split(";")[0]
          : "1",
    );
    final recurrenceEndDate = useTextEditingController(
      text: event.recurrenceRule != ""
          ? DateFormat.yMd(locale).format(
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
                    ? AppLocalizations.of(context)!.eventEditEvent
                    : AppLocalizations.of(context)!.eventAddEvent,
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
                          label: AppLocalizations.of(context)!.eventName,
                        ),
                        const SizedBox(height: 30),
                        TextEntry(
                          controller: organizer,
                          label: AppLocalizations.of(context)!.eventOrganizer,
                        ),
                        const SizedBox(height: 30),
                        CheckBoxEntry(
                          title: AppLocalizations.of(context)!.eventRecurrence,
                          valueNotifier: recurrent,
                          onChanged: () {
                            start.text = "";
                            end.text = "";
                            recurrenceEndDate.text = "";
                          },
                        ),
                        const SizedBox(height: 20),
                        CheckBoxEntry(
                          title: AppLocalizations.of(context)!.eventAllDay,
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
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.eventRecurrenceDays,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Column(
                                        children: eventDayKeys
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                              final index = entry.key;
                                              final key = entry.value;
                                              final localizedLabel =
                                                  getLocalizedEventDay(
                                                    context,
                                                    key,
                                                  );

                                              return GestureDetector(
                                                onTap: () =>
                                                    selectedDaysNotifier.toggle(
                                                      index,
                                                    ),
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      localizedLabel,
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
                                                          selectedDays[index],
                                                      onChanged: (_) =>
                                                          selectedDaysNotifier
                                                              .toggle(index),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                            .toList(),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.eventInterval,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextEntry(
                                        label: AppLocalizations.of(
                                          context,
                                        )!.eventInterval,
                                        controller: interval,
                                        prefix: AppLocalizations.of(
                                          context,
                                        )!.eventEventEvery,
                                        suffix: AppLocalizations.of(
                                          context,
                                        )!.eventWeeks,
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
                                              label: AppLocalizations.of(
                                                context,
                                              )!.eventStartHour,
                                            ),
                                            const SizedBox(height: 30),
                                            DateEntry(
                                              onTap: () =>
                                                  getOnlyHourDate(context, end),
                                              controller: end,
                                              label: AppLocalizations.of(
                                                context,
                                              )!.eventEndHour,
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
                                        label: AppLocalizations.of(
                                          context,
                                        )!.eventRecurrenceEndDate,
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
                                    label: AppLocalizations.of(
                                      context,
                                    )!.eventStartDate,
                                  ),
                                  const SizedBox(height: 30),
                                  DateEntry(
                                    onTap: () => allDay.value
                                        ? getOnlyDayDate(context, end)
                                        : getFullDate(context, end),
                                    controller: end,
                                    label: AppLocalizations.of(
                                      context,
                                    )!.eventEndDate,
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
                          AppLocalizations.of(context)!.eventRoom,
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
                          AppLocalizations.of(context)!.eventOther,
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
                            label: AppLocalizations.of(context)!.eventLocation,
                          ),
                        ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        TextEntry(
                          controller: description,
                          label: AppLocalizations.of(context)!.eventDescription,
                          keyboardType: TextInputType.multiline,
                        ),
                        const SizedBox(height: 50),
                        WaitingButton(
                          builder: (child) => AddEditButtonLayout(child: child),
                          onTap: () async {
                            if (key.currentState == null) {
                              return;
                            }
                            final editedEventMsg = AppLocalizations.of(
                              context,
                            )!.eventEditedEvent;
                            final addedEventMsg = AppLocalizations.of(
                              context,
                            )!.eventAddedEvent;
                            final editingErrorMsg = AppLocalizations.of(
                              context,
                            )!.eventEditingError;
                            final addingErrorMsg = AppLocalizations.of(
                              context,
                            )!.eventAddingError;
                            if (key.currentState!.validate()) {
                              if (allDay.value) {
                                start.text =
                                    "${!recurrent.value ? "${start.text} " : ""}00:00";
                                end.text =
                                    "${!recurrent.value ? "${end.text} " : ""}23:59";
                              }
                              if (end.text.contains("/") &&
                                  isDateBefore(
                                    processDateBack(end.text, locale.toString()),
                                    processDateBack(start.text, locale.toString()),
                                  )) {
                                displayToast(
                                  context,
                                  TypeMsg.error,
                                  AppLocalizations.of(
                                    context,
                                  )!.eventInvalidDates,
                                );
                              } else if (recurrent.value &&
                                  selectedDays
                                      .where((element) => element)
                                      .isEmpty) {
                                displayToast(
                                  context,
                                  TypeMsg.error,
                                  AppLocalizations.of(
                                    context,
                                  )!.eventNoDaySelected,
                                );
                              } else {
                                await tokenExpireWrapper(ref, () async {
                                  String recurrenceRule = "";
                                  String startString = start.text;
                                  if (!startString.contains("/")) {
                                    startString =
                                        "${DateFormat.yMd(locale).format(now)} $startString";
                                  }
                                  String endString = end.text;
                                  if (!endString.contains("/")) {
                                    endString =
                                        "${DateFormat.yMd(locale).format(now)} $endString";
                                  }
                                  if (recurrent.value) {
                                    RecurrenceProperties recurrence =
                                        RecurrenceProperties(startDate: now);
                                    recurrence.recurrenceType =
                                        RecurrenceType.weekly;
                                    recurrence.recurrenceRange =
                                        RecurrenceRange.endDate;
                                    recurrence.endDate = DateTime.parse(
                                      processDateBack(recurrenceEndDate.text, locale.toString()),
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
                                        processDateBackWithHour(startString, locale.toString()),
                                      ),
                                      DateTime.parse(
                                        processDateBackWithHour(endString, locale.toString()),
                                      ),
                                    );
                                  }
                                  Event newEvent = Event(
                                    id: isEdit ? event.id : "",
                                    description: description.text,
                                    end: DateTime.parse(
                                      processDateBack(endString, locale.toString()),
                                    ),
                                    name: name.text,
                                    organizer: organizer.text,
                                    allDay: allDay.value,
                                    location: location.text,
                                    start: DateTime.parse(
                                      processDateBack(startString, locale.toString()),
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
                                        editedEventMsg,
                                      );
                                    } else {
                                      displayToastWithContext(
                                        TypeMsg.msg,
                                        addedEventMsg,
                                      );
                                    }
                                  } else {
                                    if (isEdit) {
                                      displayToastWithContext(
                                        TypeMsg.error,
                                        editingErrorMsg,
                                      );
                                    } else {
                                      displayToastWithContext(
                                        TypeMsg.error,
                                        addingErrorMsg,
                                      );
                                    }
                                  }
                                });
                              }
                            }
                          },
                          child: Text(
                            isEdit
                                ? AppLocalizations.of(context)!.eventEdit
                                : AppLocalizations.of(context)!.eventAdd,
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
