import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/drawer/providers/is_web_format_provider.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/confirmed_event_list_provider.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends HookConsumerWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(confirmedEventListProvider);
    final isWebFormat = ref.watch(isWebFormatProvider);

    void calendarTapped(CalendarTapDetails details, BuildContext context) {
      if (details.targetElement == CalendarElement.appointment ||
          details.targetElement == CalendarElement.agenda) {
        final Appointment appointmentDetails = details.appointments![0];
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 220 +
                            (appointmentDetails.notes!.length / 30 - 5) * 15,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(appointmentDetails.subject,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            const SizedBox(height: 10),
                            Text(
                              formatDates(
                                  appointmentDetails.startTime,
                                  appointmentDetails.endTime,
                                  appointmentDetails.isAllDay),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade400,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(appointmentDetails.notes ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 15)),
                          ],
                        ),
                      ),
                      Positioned(
                          top: -10,
                          right: -10,
                          child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: CardButton(
                                  color: Colors.white,
                                  shadowColor:
                                      Colors.grey.shade500.withOpacity(0.3),
                                  child: const HeroIcon(
                                    HeroIcons.xMark,
                                    size: 20,
                                  ))))
                    ],
                  ));
            });
      }
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final CalendarController calendarController = CalendarController();
      return SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: AsyncChild(
            value: events,
            builder: (context, res) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Stack(
                    children: [
                      SfCalendar(
                        onTap: (details) => calendarTapped(details, context),
                        dataSource: _getCalendarDataSource(res),
                        view: CalendarView.week,
                        controller: calendarController,
                        selectionDecoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          shape: BoxShape.rectangle,
                        ),
                        todayHighlightColor: Colors.black,
                        todayTextStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        firstDayOfWeek: 1,
                        timeZone: 'Europe/Paris',
                        timeSlotViewSettings: const TimeSlotViewSettings(
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
                                      color:
                                          Colors.grey.shade700.withOpacity(0.3),
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
                                      color:
                                          Colors.grey.shade700.withOpacity(0.3),
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
                ),
            loaderColor: ColorConstants.background2),
      );
    });
  }
}

_AppointmentDataSource _getCalendarDataSource(List<Event> res) {
  List<Appointment> appointments = <Appointment>[];
  res.map((e) {
    if (e.recurrenceRule != "") {
      final dates = getDateInRecurrence(e.recurrenceRule, e.start);
      dates.map((data) {
        appointments.add(Appointment(
          startTime: combineDate(data, e.start),
          endTime: combineDate(data, e.end),
          subject: '${e.name} - ${e.organizer}',
          isAllDay: e.allDay,
          startTimeZone: "Europe/Paris",
          endTimeZone: "Europe/Paris",
          notes: e.description,
          color: generateColor(e.location),
        ));
      }).toList();
    } else {
      appointments.add(Appointment(
        startTime: e.start,
        endTime: e.end,
        subject: '${e.name} - ${e.organizer}',
        isAllDay: e.allDay,
        startTimeZone: "Europe/Paris",
        endTimeZone: "Europe/Paris",
        notes: e.description,
        color: generateColor(e.location),
      ));
    }
  }).toList();
  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
