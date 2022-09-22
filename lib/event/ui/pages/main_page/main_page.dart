import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/event/ui/pages/main_page/event_ui.dart';
import 'package:myecl/event/ui/refresh_indicator.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(eventPageProvider.notifier);
    final eventNotifier = ref.watch(eventListProvider.notifier);
    final events = ref.watch(eventListProvider);
    return Expanded(
        child: EventRefresher(
            onRefresh: () async {
              await eventNotifier.loadEventList();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            colors: [
                              EventColorConstants.blueGradient1,
                              EventColorConstants.blueGradient2
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                              color: EventColorConstants.blueGradient1
                                  .withOpacity(0.4),
                              offset: const Offset(0, 3),
                              blurRadius: 6)
                        ],
                      ),
                      child: const Text(EventTextConstants.addEvent,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    onTap: () {
                      pageNotifier.setEventPage(EventPage.addEvent);
                    },
                  ),
                  events.when(data: (events) {
                    return Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                            events.isEmpty
                                ? EventTextConstants.noEvent
                                : EventTextConstants.eventList,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              return EventUi(e: events[index]);
                            }),
                      ],
                    );
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  }, error: (error, stack) {
                    return const Center(
                      child: Text('error'),
                    );
                  })
                ],
              ),
            )));
  }
}
