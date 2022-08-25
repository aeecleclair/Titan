import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class EditBookingPage extends HookConsumerWidget {
  const EditBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    final _currentStep = useState(0);
    final key = GlobalKey<FormState>();
    final rooms = ref.watch(roomListProvider);
    final bookingListNotifier = ref.watch(bookingListProvider.notifier);
    final booking = ref.watch(bookingProvider);
    final bookingNotifier = ref.watch(bookingProvider.notifier);
    final room = useState(booking.room);
    final start = useTextEditingController(text: booking.start.toString());
    final end = useTextEditingController(text: booking.end.toString());
    final motif = useTextEditingController(text: booking.reason);
    final motifFocus = useState(false);
    final note = useTextEditingController(text: booking.note);
    final noteFocus = useState(false);
    final recurring = useState(booking.recurring);
    final multipleDay = useState(booking.multipleDay);
    final keyRequired = useState(booking.key);

    Widget w = const Center(
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(BookingColorConstants.veryLightBlue),
      ),
    );

    rooms.when(
      data: (roomList) {
        if (roomList.isNotEmpty) {
          List<Step> steps = [
            Step(
              title: const Text(BookingTextConstants.room,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              content: Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: BookingColorConstants.veryLightBlue,
                  unselectedWidgetColor: BookingColorConstants.veryLightBlue,
                ),
                child: Column(
                    children: roomList
                        .map(
                          (e) => RadioListTile(
                              title: Text(capitalize(e.name),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              selected: room.value.name == e.name,
                              value: e.name,
                              activeColor: BookingColorConstants.lightBlue,
                              groupValue: room.value.name,
                              onChanged: (s) {
                                room.value = e;
                                bookingNotifier
                                    .setBooking(booking.copyWith(room: e));
                              }),
                        )
                        .toList()),
              ),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 0
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text(BookingTextConstants.dates,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              content: Column(
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
                              BookingTextConstants.startDate,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 85, 85, 85),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectDate(context, start).then((value) {
                                if (value != null) {
                                  bookingNotifier.setBooking(
                                      booking.copyWith(start: start.value));
                                }
                              });
                            },
                            child: SizedBox(
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: start,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    isDense: true,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 85, 85, 85))),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    errorBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 158, 158, 158),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return BookingTextConstants.noDateError;
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 0, 0, 0),
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
                                BookingTextConstants.endDate,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 85, 85, 85),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectDate(context, end).then((value) {
                                  if (value != null) {
                                    bookingNotifier.setBooking(
                                        booking.copyWith(end: end.value));
                                  }
                                });
                              },
                              child: SizedBox(
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: end,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      isDense: true,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 85, 85, 85))),
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
                                        return BookingTextConstants.noDateError;
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ])),
                ],
              ),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 1
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text(BookingTextConstants.reason,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              content: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: BookingTextConstants.bookingReason,
                    ),
                    controller: motif,
                    autofocus: motifFocus.value,
                    onChanged: (value) {
                      bookingNotifier
                          .setBooking(booking.copyWith(reason: value));
                      motifFocus.value = true;
                      noteFocus.value = false;
                    },
                    validator: (value) {
                      if (value == null) {
                        return BookingTextConstants.noReasonError;
                      }
                      return null;
                    },
                  ),
                ],
              ),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 2
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text(BookingTextConstants.note,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              content: TextFormField(
                decoration: const InputDecoration(
                    labelText: BookingTextConstants.bookingNote),
                controller: note,
                autofocus: noteFocus.value,
                onChanged: (value) {
                  bookingNotifier.setBooking(booking.copyWith(note: value));
                  noteFocus.value = true;
                  motifFocus.value = false;
                },
                validator: (value) {
                  if (value == null) {
                    return BookingTextConstants.noNoteError;
                  }
                  return null;
                },
              ),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 3
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text(BookingTextConstants.other,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              content: Column(children: [
                CheckboxListTile(
                  title: const Text(BookingTextConstants.necessaryKey),
                  value: keyRequired.value,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      keyRequired.value = newValue;
                      bookingNotifier
                          .setBooking(booking.copyWith(key: newValue));
                      motifFocus.value = false;
                      noteFocus.value = false;
                    }
                  },
                ),
                CheckboxListTile(
                  title: const Text(BookingTextConstants.recurrent),
                  value: recurring.value,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      recurring.value = newValue;
                      bookingNotifier
                          .setBooking(booking.copyWith(recurring: newValue));
                      motifFocus.value = false;
                      noteFocus.value = false;
                    }
                  },
                ),
                CheckboxListTile(
                  title: const Text(BookingTextConstants.multipleDay),
                  value: multipleDay.value,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      multipleDay.value = newValue;
                      bookingNotifier
                          .setBooking(booking.copyWith(multipleDay: newValue));
                      motifFocus.value = false;
                      noteFocus.value = false;
                    }
                  },
                )
              ]),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 4
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text(BookingTextConstants.confirmation,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              content: Column(
                children: <Widget>[
                  Row(
                    children: [
                      const Text(BookingTextConstants.room + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(room.value.name,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(BookingTextConstants.startDate + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(start.value.text,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(BookingTextConstants.endDate + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(end.value.text,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(BookingTextConstants.reason + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(motif.text,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(BookingTextConstants.note + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(note.text,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(BookingTextConstants.necessaryKey + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(keyRequired.value.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(BookingTextConstants.recurrent + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(recurring.value.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(BookingTextConstants.multipleDay + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(multipleDay.value.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ],
              ),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 5
                  ? StepState.complete
                  : StepState.disabled,
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
                                    // displayBookingToast(context, TypeMsg.error,
                                    //     LoanTextConstants.invalidDates);
                                  } else if (room.value.id.isEmpty) {
                                    // displayBookingToast(context, TypeMsg.error,
                                    //     LoanTextConstants.invalidRoom);
                                  } else {
                                    tokenExpireWrapper(ref, () async {
                                      final value = await bookingListNotifier
                                          .updateBooking(Booking(
                                              id: booking.id,
                                              reason: motif.text,
                                              start: DateTime.parse(
                                                  start.value.text),
                                              end: DateTime.parse(
                                                  end.value.text),
                                              note: note.text,
                                              room: room.value,
                                              key: keyRequired.value,
                                              decision: Decision.pending,
                                              multipleDay: multipleDay.value,
                                              recurring: recurring.value));
                                      print(value);
                                      if (value) {
                                        // displayLoanToast(
                                        //     context,
                                        //     TypeMsg.msg,
                                        //     LoanTextConstants.addedLoan);
                                        pageNotifier
                                            .setBookingPage(BookingPage.main);
                                      } else {
                                        // displayLoanToast(
                                        //     context,
                                        //     TypeMsg.error,
                                        //     LoanTextConstants
                                        //         .addingError);
                                      }
                                    });
                                  }
                                } else {
                                  // displayLoanToast(
                                  //     context,
                                  //     TypeMsg.error,
                                  //     LoanTextConstants
                                  //         .incorrectOrMissingFields);
                                }
                              },
                        child: (isLastStep)
                            ? const Text(BookingTextConstants.add)
                            : const Text(BookingTextConstants.next),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (_currentStep.value > 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controls.onStepCancel,
                          child: const Text(BookingTextConstants.previous),
                        ),
                      )
                  ],
                );
              },
              steps: steps,
            ),
          );
        } else {
          w = const Text(BookingTextConstants.noRoomFound);
        }
      },
      error: (e, s) {
        w = Text(e.toString());
      },
      loading: () {},
    );

    return Expanded(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), child: w),
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
