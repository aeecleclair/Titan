import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/providers/selected_days_provider.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AddEventPage extends HookConsumerWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(eventPageProvider.notifier);
    final _currentStep = useState(0);
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
    final dayList = [
      'Lundi',
      'Mardi',
      'Mercredi',
      'Jeudi',
      'Vendredi',
      'Samedi',
      'Dimanche'
    ];
    Widget w = const Center(
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(EventColorConstants.blueGradient1),
      ),
    );

    List<Step> steps = [
      Step(
        title: const Text(EventTextConstants.eventType,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        content: Column(
            children: CalendarEventType.values
                .map(
                  (e) => RadioListTile(
                      title: Text(calendarEventTypeToString(e),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      selected: eventType.value.toString() == e.toString(),
                      value: e,
                      activeColor: Colors.black,
                      groupValue: eventType.value,
                      onChanged: (s) {
                        eventType.value = e;
                      }),
                )
                .toList()),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(EventTextConstants.name,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        content: TextFormField(
          decoration: const InputDecoration(
            labelText: EventTextConstants.name,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            contentPadding: EdgeInsets.all(10),
            isDense: true,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
            errorBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 158, 158, 158),
              ),
            ),
          ),
          controller: name,
          validator: (value) {
            if (value == null) {
              return EventTextConstants.noNameError;
            }
            return null;
          },
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 3 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(EventTextConstants.organizer,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        content: TextFormField(
          decoration: const InputDecoration(
            labelText: EventTextConstants.organizer,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            contentPadding: EdgeInsets.all(10),
            isDense: true,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
            errorBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 158, 158, 158),
              ),
            ),
          ),
          controller: organizer,
          validator: (value) {
            if (value == null) {
              return EventTextConstants.noOrganizerError;
            }
            return null;
          },
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 3 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(EventTextConstants.dates,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        content: Column(
          children: [
            CheckboxListTile(
              title: const Text(EventTextConstants.recurrence,
                  style: TextStyle(color: Colors.black)),
              value: recurrent.value,
              onChanged: (newValue) {
                if (newValue != null) {
                  recurrent.value = newValue;
                  start.text = "";
                  end.text = "";
                }
              },
            ),
            CheckboxListTile(
              title: const Text(EventTextConstants.allDay,
                  style: TextStyle(color: Colors.black)),
              value: allDay.value,
              onChanged: (newValue) {
                if (newValue != null) {
                  allDay.value = newValue;
                  start.text = "";
                  end.text = "";
                }
              },
            ),
            recurrent.value
                ? Column(
                    children: [
                      Column(
                        children: [
                          const Text(EventTextConstants.recurrenceDays,
                              style: TextStyle(color: Colors.black)),
                          Column(
                              children: dayList
                                  .map(
                                    (e) => CheckboxListTile(
                                      title: Text(e,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                      value: selectedDays[dayList.indexOf(e)],
                                      onChanged: (s) {
                                        selectedDaysNotifier
                                            .toggle(dayList.indexOf(e));
                                      },
                                    ),
                                  )
                                  .toList()),
                          const Text(EventTextConstants.interval,
                              style: TextStyle(color: Colors.black)),
                          TextFormField(
                            decoration: InputDecoration(
                              prefix: Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: const Text(EventTextConstants.eventEvery,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                              ),
                              suffix: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: const Text(EventTextConstants.weeks,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                              ),
                              labelText: EventTextConstants.interval,
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              isDense: true,
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 158, 158, 158),
                                ),
                              ),
                            ),
                            controller: interval,
                            validator: (value) {
                              if (value == null) {
                                return EventTextConstants.noDescriptionError;
                              } else if (int.tryParse(value) == null) {
                                return EventTextConstants.invalidIntervalError;
                              } else if (int.parse(value) < 1) {
                                return EventTextConstants.invalidIntervalError;
                              }
                              return null;
                            },
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          if (!allDay.value)
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 30),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin:
                                              const EdgeInsets.only(bottom: 3),
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: const Text(
                                            EventTextConstants.startDate,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => allDay.value
                                              ? _selectDate(context, start)
                                              : _selectOnlyHour(context, start),
                                          child: SizedBox(
                                            child: AbsorbPointer(
                                              child: TextFormField(
                                                controller: start,
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  isDense: true,
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .blue)),
                                                  errorBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red)),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 158, 158, 158),
                                                    ),
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
                                      ]),
                                ),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 30),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsets.only(
                                                bottom: 3),
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: const Text(
                                              EventTextConstants.endDate,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => allDay.value
                                                ? _selectDate(context, end)
                                                : _selectOnlyHour(context, end),
                                            child: SizedBox(
                                              child: AbsorbPointer(
                                                child: TextFormField(
                                                  controller: end,
                                                  decoration:
                                                      const InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    isDense: true,
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black)),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .blue)),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red)),
                                                    border:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 158, 158, 158),
                                                      ),
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
                                        ])),
                              ],
                            ),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(bottom: 3),
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text(
                                        EventTextConstants.recurrenceEndDate,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _selectOnlyDayDate(
                                          context, recurrenceEndDate),
                                      child: SizedBox(
                                        child: AbsorbPointer(
                                          child: TextFormField(
                                            controller: recurrenceEndDate,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              isDense: true,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.blue)),
                                              errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 158, 158, 158),
                                                ),
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
                                  ])),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(bottom: 3),
                                padding: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  EventTextConstants.startDate,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => allDay.value
                                    ? _selectOnlyDayDate(context, start)
                                    : _selectDate(context, start),
                                child: SizedBox(
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: start,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        isDense: true,
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.blue)),
                                        errorBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 158, 158, 158),
                                          ),
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
                            ]),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(bottom: 3),
                                  padding: const EdgeInsets.only(left: 10),
                                  child: const Text(
                                    EventTextConstants.endDate,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
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
                                          contentPadding: EdgeInsets.all(10),
                                          isDense: true,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue)),
                                          errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 158, 158, 158),
                                            ),
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
                              ])),
                    ],
                  ),
          ],
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(EventTextConstants.place,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: EventTextConstants.place,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 158, 158, 158),
                  ),
                ),
              ),
              controller: place,
              validator: (value) {
                if (value == null) {
                  return EventTextConstants.noPlaceError;
                }
                return null;
              },
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(EventTextConstants.description,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: EventTextConstants.description,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 158, 158, 158),
                  ),
                ),
              ),
              controller: description,
              validator: (value) {
                if (value == null) {
                  return EventTextConstants.noDescriptionError;
                }
                return null;
              },
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(EventTextConstants.confirmation,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        content: Column(
          children: <Widget>[
            Row(
              children: [
                const Text(EventTextConstants.eventType + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text(calendarEventTypeToString(eventType.value),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
            Row(
              children: [
                const Text(EventTextConstants.name + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text(name.text,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
            Row(
              children: [
                const Text(EventTextConstants.organizer + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text(organizer.text,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
            if (!recurrent.value || !allDay.value)
              Row(
                children: [
                  const Text(EventTextConstants.startDate + " : ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text(start.value.text,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
            if (!recurrent.value || !allDay.value)
              Row(
                children: [
                  const Text(EventTextConstants.endDate + " : ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text(end.value.text,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
            Row(
              children: [
                const Text(EventTextConstants.place + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text(place.text,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
            Row(
              children: [
                const Text(EventTextConstants.description + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text(description.text,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
            Row(
              children: [
                const Text(EventTextConstants.recurrence + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text(
                    recurrent.value
                        ? EventTextConstants.yes
                        : EventTextConstants.no,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
            if (recurrent.value)
              Column(
                children: [
                  Row(
                    children: [
                      const Text(EventTextConstants.recurrenceDays + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text(
                          dayList
                              .where((element) =>
                                  selectedDays[dayList.indexOf(element)])
                              .join(", "),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(EventTextConstants.interval + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text(
                          "Toutes les " +
                              (interval.text != "1"
                                  ? interval.text + " "
                                  : "") +
                              "semaines",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(EventTextConstants.recurrenceEndDate + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text(recurrenceEndDate.value.text,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                ],
              ),
          ],
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 5 ? StepState.complete : StepState.disabled,
      ),
    ];

    void continued() {
      _currentStep.value < steps.length ? _currentStep.value += 1 : null;
    }

    void cancel() {
      _currentStep.value > 0 ? _currentStep.value -= 1 : null;
    }

    w = Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: key,
      child: Stepper(
        physics: const BouncingScrollPhysics(),
        currentStep: _currentStep.value,
        onStepTapped: (step) => _currentStep.value = step,
        onStepContinue: continued,
        onStepCancel: cancel,
        controlsBuilder: (context, ControlsDetails controls) {
          final isLastStep = _currentStep.value == steps.length - 1;
          return Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: !isLastStep
                      ? controls.onStepContinue
                      : () {
                          if (key.currentState == null) {
                            return;
                          }
                          if (key.currentState!.validate()) {
                            if (start.text == "") {
                              start.text = DateTime.now().subtract(const Duration(minutes: 1)).toString();
                            }
                            if (end.text == "") {
                              end.text = DateTime.now().toString();
                            }
                            if (start.text.compareTo(end.text) >= 0) {
                              displayEventToast(context, TypeMsg.error,
                                  EventTextConstants.invalidDates);
                            } else {
                              tokenExpireWrapper(ref, () async {
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
                                final recurrenceRule = SfCalendar.generateRRule(
                                    recurrence,
                                    DateTime.parse(start.text),
                                    DateTime.parse(end.text));
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
                                  displayEventToast(context, TypeMsg.msg,
                                      EventTextConstants.addedEvent);
                                } else {
                                  displayEventToast(context, TypeMsg.error,
                                      EventTextConstants.addingError);
                                }
                              });
                            }
                          } else {
                            displayEventToast(context, TypeMsg.error,
                                EventTextConstants.incorrectOrMissingFields);
                          }
                        },
                  child: (isLastStep)
                      ? const Text(EventTextConstants.add)
                      : const Text(EventTextConstants.next),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              if (_currentStep.value > 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: controls.onStepCancel,
                    child: const Text(EventTextConstants.previous),
                  ),
                )
            ],
          );
        },
        steps: steps,
      ),
    );

    return Expanded(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), child: w),
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
    dateController.text = DateFormat('yyyy-MM-dd').format(picked ?? now);
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
