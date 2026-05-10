import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/drawer/providers/is_web_format_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class Calendar extends HookConsumerWidget {
  final CalendarDataSource<Object?> dataSource;
  final AsyncValue<List<Object?>> items;
  const Calendar({super.key, required this.dataSource, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height:
                        220 + (appointmentDetails.notes!.length / 30 - 5) * 15,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          appointmentDetails.subject,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          formatDates(
                            appointmentDetails.startTime,
                            appointmentDetails.endTime,
                            appointmentDetails.isAllDay,
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          appointmentDetails.notes ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -10,
                    right: -10,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: CardButton(
                        color: Theme.of(context).colorScheme.surface,
                        shadowColor: Theme.of(context).shadowColor,
                        child: const HeroIcon(HeroIcons.xMark, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final CalendarController calendarController = CalendarController();
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: AsyncChild(
            value: items,
            builder: (context, res) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                  children: [
                    SfCalendar(
                      onTap: (details) => calendarTapped(details, context),
                      dataSource: dataSource,
                      controller: calendarController,
                      view: CalendarView.week,
                      selectionDecoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onPrimary,
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        shape: BoxShape.rectangle,
                      ),
                      todayHighlightColor: Theme.of(
                        context,
                      ).colorScheme.secondary,
                      todayTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                      firstDayOfWeek: 1,
                      timeZone: 'Europe/Paris',
                      timeSlotViewSettings: const TimeSlotViewSettings(
                        timeFormat: 'HH:mm',
                      ),
                      viewHeaderStyle: ViewHeaderStyle(
                        dayTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        dateTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      headerStyle: CalendarHeaderStyle(
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
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
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              calendarController.forward!();
                            },
                            icon: HeroIcon(
                              HeroIcons.arrowRight,
                              size: 25,
                              color: Theme.of(context).colorScheme.onSecondary,
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
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              calendarController.backward!();
                            },
                            icon: HeroIcon(
                              HeroIcons.arrowLeft,
                              size: 25,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
            loaderColor: Theme.of(context).colorScheme.primaryContainer,
          ),
        );
      },
    );
  }
}
