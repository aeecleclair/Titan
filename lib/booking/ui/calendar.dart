import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/is_manager_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/drawer/providers/is_web_format_provider.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class Calendar extends HookConsumerWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(confirmedBookingListProvider);
    final isWebFormat = ref.watch(isWebFormatProvider);
    final isManager = ref.watch(isManagerProvider);
    final CalendarController calendarController = CalendarController();

    void calendarTapped(CalendarTapDetails details, BuildContext context) {
      if (details.targetElement == CalendarElement.appointment ||
          details.targetElement == CalendarElement.agenda) {
        final Booking booking = details.appointments![0];
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _CalendarDialog(
              booking: booking,
              isManager: isManager,
            );
          },
        );
      }
    }

    return bookings.when(data: (res) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            SfCalendar(
              onTap: (details) => calendarTapped(details, context),
              dataSource: _AppointmentDataSource(res),
              controller: calendarController,
              view: CalendarView.week,
              selectionDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                shape: BoxShape.rectangle,
              ),
              todayHighlightColor: Colors.black,
              todayTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              firstDayOfWeek: 1,
              timeZone: 'Europe/Paris',
              timeSlotViewSettings: const TimeSlotViewSettings(
                timeIntervalHeight: 25,
                timeFormat: 'HH:mm',
              ),
              viewHeaderStyle: const ViewHeaderStyle(
                  dayTextStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  dateTextStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  )),
              headerStyle: const CalendarHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            if (isWebFormat)
              Positioned(
                right: 30,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade700.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 1)
                      ]),
                  child: IconButton(
                    onPressed: () {
                      calendarController.forward!();
                    },
                    icon: const HeroIcon(
                      HeroIcons.arrowRight,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if (isWebFormat)
              Positioned(
                left: 30,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade700.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 1)
                      ]),
                  child: IconButton(
                    onPressed: () {
                      calendarController.backward!();
                    },
                    icon: const HeroIcon(
                      HeroIcons.arrowLeft,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }, error: (Object error, StackTrace? stackTrace) {
      return Center(
        child: Text(error.toString()),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(
          color: ColorConstants.background2,
        ),
      );
    });
  }
}

class _AppointmentDataSource extends CalendarDataSource<Booking> {
  _AppointmentDataSource(List<Booking> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) => appointments![index].start;

  @override
  DateTime getEndTime(int index) => appointments![index].end;

  @override
  Color getColor(int index) => generateColor(appointments![index].room.name);

  @override
  String getSubject(int index) {
    Booking booking = appointments![index];
    return '${booking.room.name} - ${booking.reason}';
  }

  @override
  bool isAllDay(int index) => false;

  @override
  String? getNotes(int index) => appointments![index].note;

  @override
  String? getStartTimeZone(int index) => "Europe/Paris";

  @override
  String? getEndTimeZone(int index) => "Europe/Paris";

  @override
  String? getRecurrenceRule(int index) {
    Booking booking = appointments![index];
    return booking.recurrenceRule.isNotEmpty ? booking.recurrenceRule : null;
  }
}

class _CalendarDialog extends StatelessWidget {
  final Booking booking;
  final bool isManager;

  const _CalendarDialog({required this.booking, required this.isManager});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          !isManager
              ? Container(
                  height: 220 + (booking.note.length / 30 - 5) * 15,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        '${booking.room.name} - ${booking.reason}',
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formatDates(
                          booking.start,
                          booking.end,
                          false,
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade400,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${BookingTextConstants.bookedfor} ${booking.entity}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ],
                  ),
                )
              : AdminDetails(booking: booking),
          Positioned(
            top: -10,
            right: -10,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade500.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 1)
                    ],
                    borderRadius: BorderRadius.circular(15)),
                child: const HeroIcon(
                  HeroIcons.xMark,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AdminDetails extends StatelessWidget {
  final Booking booking;

  const AdminDetails({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    void displayToastWithoutContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    return Container(
      margin: const EdgeInsets.all(30.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeText(
              booking.applicant.getName(),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () async {
                try {
                  await launchUrl(
                      Uri.parse('mailto:${booking.applicant.email}'));
                } catch (e) {
                  displayToastWithoutContext(TypeMsg.error, e.toString());
                }
              },
              child: Text(
                booking.applicant.email,
                style: const TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            if (booking.entity.isNotEmpty)
              AutoSizeText(
                "${BookingTextConstants.bookedfor} ${booking.entity}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(
              height: 50,
            ),
            Text(
              booking.applicant.phone ?? BookingTextConstants.noPhoneRegistered,
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (booking.applicant.phone != null) {
                      try {
                        await launchUrl(
                            Uri.parse('tel:${booking.applicant.phone}'));
                      } catch (e) {
                        displayToastWithoutContext(TypeMsg.error, e.toString());
                      }
                    }
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      color: Colors.grey.shade50,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const HeroIcon(
                      HeroIcons.phone,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 100),
                GestureDetector(
                  onTap: () async {
                    if (booking.applicant.phone != null) {
                      try {
                        await launchUrl(
                            Uri.parse('sms:${booking.applicant.phone}'));
                      } catch (e) {
                        displayToastWithoutContext(TypeMsg.error, e.toString());
                      }
                    }
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      color: Colors.grey.shade50,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const HeroIcon(
                      HeroIcons.chatBubbleBottomCenterText,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}
