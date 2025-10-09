import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/event/ui/event.dart';
import 'package:titan/event/class/event.dart';
import 'package:titan/event/providers/event_list_provider.dart';
import 'package:titan/event/tools/constants.dart';
import 'package:titan/event/ui/pages/admin_page/list_event.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/widgets/calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventListProvider);

    final List<Event> pendingEvents = [],
        confirmedEvents = [],
        canceledEvents = [];
    events.maybeWhen(
      data: (events) {
        for (Event b in events) {
          switch (b.decision) {
            case Decision.approved:
              confirmedEvents.add(b);
              break;
            case Decision.declined:
              canceledEvents.add(b);
              break;
            case Decision.pending:
              pendingEvents.add(b);
              break;
          }
        }
      },
      orElse: () {},
    );
    List<Appointment> appointments = <Appointment>[];
    confirmedEvents.map((e) {
      if (e.recurrenceRule != "") {
        final dates = getDateInRecurrence(e.recurrenceRule, e.start);
        dates.map((data) {
          appointments.add(
            Appointment(
              startTime: combineDate(data, e.start),
              endTime: combineDate(data, e.end),
              subject: '${e.name} - ${e.organizer}',
              isAllDay: e.allDay,
              startTimeZone: "Europe/Paris",
              endTimeZone: "Europe/Paris",
              notes: e.description,
              color: generateColor(e.location),
            ),
          );
        }).toList();
      } else {
        appointments.add(
          Appointment(
            startTime: e.start,
            endTime: e.end,
            subject: '${e.name} - ${e.organizer}',
            isAllDay: e.allDay,
            startTimeZone: "Europe/Paris",
            endTimeZone: "Europe/Paris",
            notes: e.description,
            color: generateColor(e.location),
          ),
        );
      }
    }).toList();
    return EventTemplate(
      child: Refresher(
        onRefresh: () async {
          await ref.watch(eventListProvider.notifier).loadEventList();
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height - 415,
              child: Calendar(
                items: events,
                dataSource: AppointmentDataSource(appointments),
              ),
            ),
            const SizedBox(height: 30),
            if (pendingEvents.isEmpty &&
                confirmedEvents.isEmpty &&
                canceledEvents.isEmpty)
              const Center(
                child: Text(
                  EventTextConstants.noCurrentEvent,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ListEvent(
              title: EventTextConstants.pending,
              events: pendingEvents,
              canToggle: false,
            ),
            ListEvent(
              title: EventTextConstants.confirmed,
              events: confirmedEvents,
            ),
            ListEvent(
              title: EventTextConstants.declined,
              events: canceledEvents,
            ),
            ListEvent(
              title: EventTextConstants.history,
              events: confirmedEvents + canceledEvents + pendingEvents,
              isHistory: true,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
