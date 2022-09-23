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
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AddBookingPage extends HookConsumerWidget {
  const AddBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    final currentStep = useState(0);
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
              content: Column(
                  children: roomList
                      .map(
                        (e) => RadioListTile(
                            title: Text(capitalize(e.name),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            selected: room.value.name == e.name,
                            value: e.name,
                            activeColor: Colors.white,
                            groupValue: room.value.name,
                            onChanged: (s) {
                              room.value = e;
                            }),
                      )
                      .toList()),
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 0
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
                                color: Colors.white,
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
                                        borderSide:
                                            BorderSide(color: Colors.white)),
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
                                    color: Colors.white,
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
                                  color: Colors.white,
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
                                          borderSide:
                                              BorderSide(color: Colors.white)),
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
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ])),
                ],
              ),
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 1
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
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      contentPadding: EdgeInsets.all(10),
                      isDense: true,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
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
                    controller: motif,
                    validator: (value) {
                      if (value == null) {
                        return BookingTextConstants.noReasonError;
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 2
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
                  labelText: BookingTextConstants.bookingNote,
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
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
                controller: note,
                validator: (value) {
                  if (value == null) {
                    return BookingTextConstants.noNoteError;
                  }
                  return null;
                },
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 3
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
                  title: const Text(BookingTextConstants.necessaryKey,
                      style: TextStyle(color: Colors.white)),
                  value: keyRequired.value,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      keyRequired.value = newValue;
                    }
                  },
                ),
                CheckboxListTile(
                  title: const Text(BookingTextConstants.recurrent,
                      style: TextStyle(color: Colors.white)),
                  value: recurring.value,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      recurring.value = newValue;
                    }
                  },
                ),
                CheckboxListTile(
                  title: const Text(BookingTextConstants.multipleDay,
                      style: TextStyle(color: Colors.white)),
                  value: multipleDay.value,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      multipleDay.value = newValue;
                    }
                  },
                )
              ]),
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 4
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
                      const Text("${BookingTextConstants.room} : ",
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
                      const Text("${BookingTextConstants.startDate} : ",
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
                      const Text("${BookingTextConstants.endDate} : ",
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
                      const Text("${BookingTextConstants.reason} : ",
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
                      const Text("${BookingTextConstants.note} : ",
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
                      const Text("${BookingTextConstants.necessaryKey} : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(
                          keyRequired.value
                              ? BookingTextConstants.yes
                              : BookingTextConstants.no,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("${BookingTextConstants.recurrent} : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(
                          recurring.value
                              ? BookingTextConstants.yes
                              : BookingTextConstants.no,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("${BookingTextConstants.multipleDay} : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(
                          multipleDay.value
                              ? BookingTextConstants.yes
                              : BookingTextConstants.no,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ],
              ),
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 5
                  ? StepState.complete
                  : StepState.disabled,
            ),
          ];

          void continued() {
            currentStep.value < steps.length ? currentStep.value += 1 : null;
          }

          void cancel() {
            currentStep.value > 0 ? currentStep.value -= 1 : null;
          }

          w = Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: key,
            child: Stepper(
              physics: const BouncingScrollPhysics(),
              currentStep: currentStep.value,
              onStepTapped: (step) => currentStep.value = step,
              onStepContinue: continued,
              onStepCancel: cancel,
              controlsBuilder: (context, ControlsDetails controls) {
                final isLastStep = currentStep.value == steps.length - 1;
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
                                          start:
                                              DateTime.parse(start.value.text),
                                          end: DateTime.parse(end.value.text),
                                          note: note.text,
                                          room: room.value,
                                          key: keyRequired.value,
                                          decision: Decision.pending,
                                          multipleDay: multipleDay.value,
                                          recurring: recurring.value);
                                      final value = await bookingListNotifier
                                          .addBooking(newBooking);
                                      if (value) {
                                        await bookingsNotifier
                                            .addBooking(newBooking);
                                        pageNotifier
                                            .setBookingPage(BookingPage.main);
                                        displayBookingToastWithContext(
                                            TypeMsg.msg,
                                            BookingTextConstants.addedBooking);
                                      } else {
                                        displayBookingToastWithContext(
                                            TypeMsg.error,
                                            BookingTextConstants.addingError);
                                      }
                                    });
                                  }
                                } else {
                                  displayBookingToast(
                                      context,
                                      TypeMsg.error,
                                      BookingTextConstants
                                          .incorrectOrMissingFields);
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
                    if (currentStep.value > 0)
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
          physics: const BouncingScrollPhysics(),
          child: Theme(
              data: Theme.of(context).copyWith(
                primaryColor: BookingColorConstants.veryLightBlue,
                unselectedWidgetColor: BookingColorConstants.veryLightBlue,
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
    dateController.text = DateFormat('yyyy-MM-dd').format(picked ?? now);
  }
}
