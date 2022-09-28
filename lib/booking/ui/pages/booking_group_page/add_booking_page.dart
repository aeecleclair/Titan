import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
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
                            }),
                      )
                      .toList()),
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 0
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
                  ),
                  DateEntry(
                    text: BookingTextConstants.endDate,
                    controller: end,
                  ),
                ],
              ),
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 1
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const StepTitle(title: BookingTextConstants.reason),
              content: TextEntry(
                  controller: motif,
                  errorMsg: BookingTextConstants.noReasonError,
                  label: BookingTextConstants.bookingReason),
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 2
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const StepTitle(title: BookingTextConstants.note),
              content: TextEntry(
                  controller: note,
                  label: BookingTextConstants.bookingNote,
                  errorMsg: BookingTextConstants.noNoteError),
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 3
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const StepTitle(title: BookingTextConstants.other),
              content: Column(children: [
                CheckBoxEntry(
                    title: BookingTextConstants.necessaryKey,
                    valueNotifier: keyRequired),
                CheckBoxEntry(
                    title: BookingTextConstants.recurrent,
                    valueNotifier: recurring),
                CheckBoxEntry(
                    title: BookingTextConstants.multipleDay,
                    valueNotifier: multipleDay),
              ]),
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 4
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
}
