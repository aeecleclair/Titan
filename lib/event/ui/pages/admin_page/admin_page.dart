import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/event/ui/calendar.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/event/ui/pages/admin_page/list_event.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventListProvider);
    final List<Event> pendingEvents = [],
        confirmedEvents = [],
        canceledEvents = [];
    events.when(
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
        error: (e, s) {},
        loading: () {});
    return Expanded(
      child: Refresher(
        onRefresh: () async {
          await ref.watch(eventListProvider.notifier).loadEventList();
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
                height: MediaQuery.of(context).size.height - 415,
                child: const Calendar()),
            const SizedBox(height: 30),
            if (pendingEvents.isEmpty &&
                confirmedEvents.isEmpty &&
                canceledEvents.isEmpty)
              const Center(
                child: Text(EventTextConstants.noCurrentEvent,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
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
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
