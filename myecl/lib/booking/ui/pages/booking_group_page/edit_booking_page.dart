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
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/booking/ui/pages/booking_group_page/checkbox_entry.dart';
import 'package:myecl/booking/ui/pages/booking_group_page/confirmation_text.dart';
import 'package:myecl/booking/ui/pages/booking_group_page/date_entry.dart';
import 'package:myecl/booking/ui/pages/booking_group_page/step_title.dart';
import 'package:myecl/booking/ui/pages/booking_group_page/text_entry.dart';
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
    final bookingsNotifier = ref.watch(userBookingListProvider.notifier);
    final booking = ref.watch(bookingProvider);
    final bookingNotifier = ref.watch(bookingProvider.notifier);
    final room = useState(booking.room);
    final start = useTextEditingController(
        text: DateFormat('yyyy-MM-dd HH:mm').format(booking.start));
    final end = useTextEditingController(
        text: DateFormat('yyyy-MM-dd HH:mm').format(booking.end));
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
              title: const StepTitle(title: BookingTextConstants.room),
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
                              bookingNotifier
                                  .setBooking(booking.copyWith(room: e));
                            }),
                      )
                      .toList()),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 0
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const StepTitle(title: BookingTextConstants.dates),
              content: Column(
                children: [
                  DateEntry(
                      text: BookingTextConstants.startDate,
                      controller: start,
                      onTap: (value) {
                        if (value != null) {
                          bookingNotifier
                              .setBooking(booking.copyWith(start: start.value));
                        }
                      }),
                  DateEntry(
                      text: BookingTextConstants.endDate,
                      controller: end,
                      onTap: (value) {
                        if (value != null) {
                          bookingNotifier
                              .setBooking(booking.copyWith(end: end.value));
                        }
                      }),
                ],
              ),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 1
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const StepTitle(title: BookingTextConstants.reason),
              content: TextEntry(
                autofocus: motifFocus.value,
                controller: motif,
                errorMsg: BookingTextConstants.noReasonError,
                label: BookingTextConstants.bookingReason,
                onChanged: (value) {
                  bookingNotifier.setBooking(booking.copyWith(reason: value));
                  motifFocus.value = true;
                  noteFocus.value = false;
                },
              ),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 2
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const StepTitle(title: BookingTextConstants.note),
              content: TextEntry(
                autofocus: noteFocus.value,
                controller: note,
                errorMsg: BookingTextConstants.noNoteError,
                label: BookingTextConstants.bookingNote,
                onChanged: (value) {
                  bookingNotifier.setBooking(booking.copyWith(note: value));
                  noteFocus.value = true;
                  motifFocus.value = false;
                },
              ),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 3
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const StepTitle(title: BookingTextConstants.other),
              content: Column(children: [
                CheckBoxEntry(
                    title: BookingTextConstants.necessaryKey,
                    valueNotifier: keyRequired,
                    onChanged: (newValue) {
                      bookingNotifier
                          .setBooking(booking.copyWith(key: newValue));
                      motifFocus.value = false;
                      noteFocus.value = false;
                    }),
                CheckBoxEntry(
                    title: BookingTextConstants.recurrent,
                    valueNotifier: recurring,
                    onChanged: (newValue) {
                      bookingNotifier
                          .setBooking(booking.copyWith(recurring: newValue));
                      motifFocus.value = false;
                      noteFocus.value = false;
                    }),
                CheckBoxEntry(
                    title: BookingTextConstants.multipleDay,
                    valueNotifier: multipleDay,
                    onChanged: (newValue) {
                      bookingNotifier
                          .setBooking(booking.copyWith(multipleDay: newValue));
                      motifFocus.value = false;
                      noteFocus.value = false;
                    }),
              ]),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 4
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const StepTitle(title: BookingTextConstants.confirmation),
              content: Column(
                children: <Widget>[
                  ConfirmationText(
                      title: BookingTextConstants.room, value: room.value.name),
                  ConfirmationText(
                      title: BookingTextConstants.startDate,
                      value: start.value.text),
                  ConfirmationText(
                      title: BookingTextConstants.endDate,
                      value: end.value.text),
                  ConfirmationText(
                      title: BookingTextConstants.reason, value: motif.text),
                  ConfirmationText(
                      title: BookingTextConstants.note, value: note.text),
                  ConfirmationText(
                      title: BookingTextConstants.necessaryKey,
                      value: keyRequired.value
                          ? BookingTextConstants.yes
                          : BookingTextConstants.no),
                  ConfirmationText(
                      title: BookingTextConstants.recurrent,
                      value: recurring.value
                          ? BookingTextConstants.yes
                          : BookingTextConstants.no),
                  ConfirmationText(
                      title: BookingTextConstants.multipleDay,
                      value: multipleDay.value
                          ? BookingTextConstants.yes
                          : BookingTextConstants.no),
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
                                    displayBookingToast(context, TypeMsg.error,
                                        BookingTextConstants.invalidDates);
                                  } else if (room.value.id.isEmpty) {
                                    displayBookingToast(context, TypeMsg.error,
                                        BookingTextConstants.invalidRoom);
                                  } else {
                                    tokenExpireWrapper(ref, () async {
                                      Booking newBooking = Booking(
                                          id: booking.id,
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
                                          .updateBooking(newBooking);
                                      if (value) {
                                        await bookingsNotifier
                                            .updateBooking(newBooking);
                                        pageNotifier
                                            .setBookingPage(BookingPage.main);
                                        displayBookingToast(
                                            context,
                                            TypeMsg.msg,
                                            BookingTextConstants.editedBooking);
                                      } else {
                                        displayBookingToast(
                                            context,
                                            TypeMsg.error,
                                            BookingTextConstants.editionError);
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
                            ? const Text(BookingTextConstants.edit)
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
