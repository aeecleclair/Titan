import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(2, 3),
              blurRadius: 10,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: [
              SfCalendar(
                view: CalendarView.week,
                selectionDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: const Color.fromARGB(255, 1, 49, 68), width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  shape: BoxShape.rectangle,
                ),
                todayHighlightColor: const Color.fromARGB(255, 2, 84, 104),
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
                    color: Color.fromARGB(255, 1, 49, 68),
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
        ),
      ),
    );
  }
}
