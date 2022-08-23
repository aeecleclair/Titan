import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends HookConsumerWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(bookingListProvider);
    return SizedBox(
      height: 360,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: BookingColorConstants.softBlack,
              offset: const Offset(2, 3),
              blurRadius: 10,
            ),
          ],
        ),
        child: bookings.when(data: (res) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Stack(
              children: [
                SfCalendar(
                  dataSource: _getCalendarDataSource(res),
                  view: CalendarView.week,
                  selectionDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        color: BookingColorConstants.darkBlue, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    shape: BoxShape.rectangle,
                  ),
                  todayHighlightColor: BookingColorConstants.lightBlue,
                  firstDayOfWeek: 1,
                  timeZone: "fr_FR",
                  timeSlotViewSettings: const TimeSlotViewSettings(
                    timeFormat: 'H:mm',
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
                      color: BookingColorConstants.darkBlue,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    height: 20,
                    width: 20,
                    color: Colors.white,
                  ),
                )
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
              color: BookingColorConstants.darkBlue,
            ),
          );
        }),
      ),
    );
  }
}

_AppointmentDataSource _getCalendarDataSource(List<Booking> res) {
  List<Appointment> appointments = <Appointment>[];
  res.map((e) {
    appointments.add(Appointment(
      startTime: e.start,
      endTime: e.end,
      subject: e.room.name,
      isAllDay: false,
      startTimeZone: "Europe/Paris",
      endTimeZone: "Europe/Paris",
    ));
  }).toList();
  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
