import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/ui/refresh_indicator.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(eventPageProvider.notifier);
    final eventNotifier = ref.watch(eventListProvider.notifier);
    final events = ref.watch(eventListProvider);
    return EventRefresher(
        onRefresh: () async {
          await eventNotifier.loadEventList();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                  child: const Text('test'),
                ),
                onTap: () {
                  pageNotifier.setEventPage(EventPage.addEvent);
                },
              ),
              events.when(
                  data: (events) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: 100,
                            color: Colors.blue,
                            child: Text(events[index].name),
                          );
                        });
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  error: (error, stack) {
                    return const Center(
                      child: Text('error'),
                    );
                  })
            ],
          ),
        ));
  }
}
