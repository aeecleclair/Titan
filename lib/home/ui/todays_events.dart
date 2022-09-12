import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/home/providers/scroll_controller_provider.dart';
import 'package:myecl/home/providers/scrolled_provider.dart';
import 'package:myecl/home/providers/today_provider.dart';
import 'package:myecl/home/tools/constants.dart';
import 'package:myecl/home/tools/functions.dart';
import 'package:myecl/home/ui/current_time.dart';
import 'package:myecl/home/ui/hour_bar.dart';
import 'package:myecl/home/ui/hour_bar_item.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TodaysEvents extends HookConsumerWidget {
  const TodaysEvents({Key? key}) : super(key: key);

  void center(
      bool _hasScrolled,
      ScrollController _scrollController,
      DateTime today,
      HasScrolledNotifier _hasScrolledNotifier,
      ValueNotifier lastPosition) {
    if (!_hasScrolled || lastPosition.value == 0.0) {
      Timer.periodic(const Duration(milliseconds: 1), (t) {
        if (_scrollController.positions.isNotEmpty) {
          _scrollController.jumpTo(
            (today.hour + today.minute / 60 + today.second / 3600) * 90.0 - 150,
          );
          lastPosition.value =
              (today.hour + today.minute / 60 + today.second / 3600) * 90.0 -
                  150;
          t.cancel();
          _hasScrolledNotifier.setHasScrolled(true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(nowProvider);
    final _scrollController = ref.watch(scrollControllerProvider);
    final _hasScrolled = ref.watch(hasScrolledProvider);
    final _hasScrolledNotifier = ref.watch(hasScrolledProvider.notifier);
    final displayToday = useState(true);
    final res = ref.watch(eventListProvider);
    final lastPosition = useState(0.0);
    center(_hasScrolled, _scrollController, today, _hasScrolledNotifier,
        lastPosition);
    return SizedBox(
      height: MediaQuery.of(context).size.height * .65,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: displayToday.value
            ? Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 15, left: 20, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Évènements du ${today.day} ${getMonth(today.month)}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                        ),
                        IconButton(
                          icon: const HeroIcon(HeroIcons.calendar),
                          onPressed: () {
                            displayToday.value = false;
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 80,
                              height: 24 * 90.0 + 3,
                              child: HourBar(),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 24 * 90.0 + 3,
                                child: Stack(
                                  children: const [
                                    HourBarItems(),
                                    CurrentTime()
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                margin: const EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height - 15,
                child: Stack(children: [
                  SfCalendar(
                    dataSource: _getCalendarDataSource(res),
                    view: CalendarView.week,
                    selectionDecoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          color: HomeColorConstants.darkBlue, width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      shape: BoxShape.rectangle,
                    ),
                    todayHighlightColor: HomeColorConstants.lightBlue,
                    firstDayOfWeek: 1,
                    // timeZone: "fr_FR",
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
                        color: HomeColorConstants.darkBlue,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const HeroIcon(HeroIcons.calendar),
                      onPressed: () {
                        displayToday.value = true;
                        _hasScrolledNotifier.setHasScrolled(false);
                        center(_hasScrolled, _scrollController, today,
                            _hasScrolledNotifier, lastPosition);
                      },
                    ),
                  )
                ])),
      ),
    );
  }
}

_AppointmentDataSource _getCalendarDataSource(AsyncValue<List<Event>> res) {
  List<Appointment> appointments = <Appointment>[];
  res.whenData((value) {
    value.map((e) {
      appointments.add(Appointment(
        startTime: e.start,
        endTime: e.end,
        subject: e.name,
        color: uuidToColor(e.id),
        isAllDay: false,
        startTimeZone: "Europe/Paris",
        endTimeZone: "Europe/Paris",
      ));
    }).toList();
  });

  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
