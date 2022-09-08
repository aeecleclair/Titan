import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

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
    final recurrenceEnd = useTextEditingController();
    final description = useTextEditingController();
    final recurrenceRule = useTextEditingController();
    final recurrence = useState(false);

    Widget w = const Center(
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(EventColorConstants.primaryColor),
      ),
    );

    List<Step> steps = [
      Step(
        title: const Text(EventTextConstants.eventType,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: EventColorConstants.accentColor)),
        content: Column(
            children: CalendarEventType.values
                .map(
                  (e) => RadioListTile(
                      title: Text(calendarEventTypeToString(e),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: EventColorConstants.accentColor)),
                      selected: eventType.value.toString() == e.toString(),
                      value: e,
                      activeColor: EventColorConstants.accentColor,
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
                color: EventColorConstants.accentColor)),
        content: TextFormField(
          decoration: const InputDecoration(
            labelText: EventTextConstants.name,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: EventColorConstants.accentColor,
            ),
            contentPadding: EdgeInsets.all(10),
            isDense: true,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: EventColorConstants.accentColor)),
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
            color: EventColorConstants.accentColor,
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
                color: EventColorConstants.accentColor)),
        content: TextFormField(
          decoration: const InputDecoration(
            labelText: EventTextConstants.organizer,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: EventColorConstants.accentColor,
            ),
            contentPadding: EdgeInsets.all(10),
            isDense: true,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: EventColorConstants.accentColor)),
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
            color: EventColorConstants.accentColor,
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
                color: EventColorConstants.accentColor)),
        content: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                          color: EventColorConstants.accentColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context, start),
                      child: SizedBox(
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: start,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: EventColorConstants.accentColor)),
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return EventTextConstants.noDateError;
                              }
                              return null;
                            },
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: EventColorConstants.accentColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                            color: EventColorConstants.accentColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context, end),
                        child: SizedBox(
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: end,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                isDense: true,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            EventColorConstants.accentColor)),
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return EventTextConstants.noDateError;
                                }
                                return null;
                              },
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: EventColorConstants.accentColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])),
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
                color: EventColorConstants.accentColor)),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: EventTextConstants.place,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: EventColorConstants.accentColor,
                ),
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: EventColorConstants.accentColor)),
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
                color: EventColorConstants.accentColor,
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
                color: EventColorConstants.accentColor)),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: EventTextConstants.description,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: EventColorConstants.accentColor,
                ),
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: EventColorConstants.accentColor)),
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
                color: EventColorConstants.accentColor,
              ),
            ),
          ],
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(EventTextConstants.recurrence,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: EventColorConstants.accentColor)),
        content: Column(
          children: [
            CheckboxListTile(
              title: const Text(EventTextConstants.recurrence,
                  style: TextStyle(color: EventColorConstants.accentColor)),
              value: recurrence.value,
              onChanged: (newValue) {
                if (newValue != null) {
                  recurrence.value = newValue;
                }
              },
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            color: EventColorConstants.accentColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => recurrence.value
                            ? _selectDate(context, recurrenceEnd)
                            : {},
                        child: SizedBox(
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: recurrenceEnd,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                isDense: true,
                                enabled: recurrence.value,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            EventColorConstants.accentColor)),
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
                              validator: (value) {
                                if (recurrence.value && value!.isEmpty) {
                                  return EventTextConstants.noDateError;
                                }
                                return null;
                              },
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: EventColorConstants.accentColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])),
            TextFormField(
              decoration: InputDecoration(
                labelText: EventTextConstants.recurrenceRule,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: EventColorConstants.accentColor,
                ),
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                enabled: recurrence.value,
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: EventColorConstants.accentColor)),
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
              controller: recurrenceRule,
              validator: (value) {
                if (recurrence.value && value == null) {
                  return EventTextConstants.noRuleError;
                }
                return null;
              },
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: EventColorConstants.accentColor,
              ),
            ),
          ],
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 4 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text(EventTextConstants.confirmation,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: EventColorConstants.accentColor)),
        content: Column(
          children: <Widget>[
            Row(
              children: [
                const Text(EventTextConstants.eventType + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
                Text(calendarEventTypeToString(eventType.value),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
              ],
            ),
            Row(
              children: [
                const Text(EventTextConstants.name + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
                Text(name.text,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
              ],
            ),
            Row(
              children: [
                const Text(EventTextConstants.organizer + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
                Text(organizer.text,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
              ],
            ),
            Row(
              children: [
                const Text(EventTextConstants.startDate + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
                Text(start.value.text,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
              ],
            ),
            Row(
              children: [
                const Text(EventTextConstants.endDate + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
                Text(end.value.text,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
              ],
            ),
            Row(
              children: [
                const Text(EventTextConstants.place + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
                Text(place.text,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
              ],
            ),
            Row(
              children: [
                const Text(EventTextConstants.description + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
                Text(description.text,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
              ],
            ),
            Row(
              children: [
                const Text(EventTextConstants.recurrence + " : ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
                Text(
                    recurrence.value
                        ? EventTextConstants.yes
                        : EventTextConstants.no,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: EventColorConstants.accentColor)),
              ],
            ),
            if (recurrence.value)
              Row(
                children: [
                  const Text(EventTextConstants.recurrenceEndDate + " : ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: EventColorConstants.accentColor)),
                  Text(recurrenceEnd.text,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: EventColorConstants.accentColor)),
                ],
              ),
            if (recurrence.value)
              Row(
                children: [
                  const Text(EventTextConstants.recurrenceRule + " : ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: EventColorConstants.accentColor)),
                  Text(recurrenceRule.text,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: EventColorConstants.accentColor)),
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
                            if (start.text.compareTo(end.text) >= 0) {
                              displayEventToast(context, TypeMsg.error,
                                  EventTextConstants.invalidDates);
                            } else {
                              tokenExpireWrapper(ref, () async {
                                Event newEvent = Event(
                                    id: '',
                                    description: description.text,
                                    end: DateTime.parse(end.text),
                                    name: name.text,
                                    organizer: organizer.text,
                                    place: place.text,
                                    recurrence: recurrence.value,
                                    start: DateTime.parse(start.text),
                                    type: eventType.value,
                                    recurrenceEndDate: recurrence.value
                                        ? DateTime.parse(recurrenceEnd.text)
                                        : null,
                                    recurrenceRule: recurrenceRule.text);
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
          physics: const BouncingScrollPhysics(),
          child: Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Color.fromARGB(255, 32, 170, 90),
                unselectedWidgetColor: EventColorConstants.accentColor,
              ),
              child: w)),
    );
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
