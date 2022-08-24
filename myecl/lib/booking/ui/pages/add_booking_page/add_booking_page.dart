import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class AddBookingPage extends HookConsumerWidget {
  const AddBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    final _currentStep = useState(0);
    final key = GlobalKey<FormState>();
    final rooms = ref.watch(roomListProvider);
    final bookingListNotifier = ref.watch(bookingListProvider.notifier);
    final room = useState(Room.empty());
    final start = useTextEditingController();
    final end = useTextEditingController();
    final motif = useTextEditingController();
    final note = useTextEditingController();
    final recurring = useState(false);
    final multipleDay = useState(false);
    final keyRequired = useState(false);

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
              title: const Text("Salle",
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
              title: const Text("Dates",
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
                              "Date de début",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 85, 85, 85),
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
                                      return "Veuillez entrer une date";
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
                                "Date de fin",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 85, 85, 85),
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
                                        return "Veuillez entrer une date";
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
              title: const Text("Motif",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              content: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Motif de la réservation",
                    ),
                    controller: motif,
                    validator: (value) {
                      if (value == null) {
                        return "Veuillez entrer un motif";
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
              title: const Text("Note",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              content: TextFormField(
                decoration: const InputDecoration(labelText: "Note"),
                controller: note,
                validator: (value) {
                  if (value == null) {
                    return "Veuillez entrer une note";
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
              title: const Text("Autres",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              content: Column(children: [
                CheckboxListTile(
                  title: Text("Clée nécessaire ?"),
                  value: keyRequired.value,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      keyRequired.value = newValue;
                    }
                  },
                ),
                CheckboxListTile(
                  title: Text("Récurrent ?"),
                  value: recurring.value,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      recurring.value = newValue;
                    }
                  },
                ),
                CheckboxListTile(
                  title: Text("Plusieurs jours ?"),
                  value: multipleDay.value,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      multipleDay.value = newValue;
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
              title: const Text("Confirmation",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              content: Column(
                children: <Widget>[
                  Row(
                    children: [
                      const Text("Salle" + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(room.value.name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Date de début" + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(start.value.text,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Date de fin" + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(end.value.text,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Motif" + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(motif.text,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Note" + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(note.text,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Clée nécessaire" + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(keyRequired.value.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Réccurent" + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(recurring.value.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Plusieurs jours" + " : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(multipleDay.value.toString(),
                          style: TextStyle(
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
                                          .addBooking(Booking(
                                              id: '',
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
                            ? const Text("Ajouter")
                            : const Text("Suivant"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (_currentStep.value > 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controls.onStepCancel,
                          child: const Text("Précédent"),
                        ),
                      )
                  ],
                );
              },
              steps: steps,
            ),
          );
        } else {
          w = const Text("Aucune salle n'a été trouvée");
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
