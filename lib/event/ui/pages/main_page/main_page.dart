import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/event/ui/event_ui.dart';
import 'package:myecl/tools/refresher.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(eventPageProvider.notifier);
    final eventNotifier = ref.watch(eventListProvider.notifier);
    final events = ref.watch(eventListProvider);
    return Expanded(
      child: Refresher(
        onRefresh: () async {
          await eventNotifier.loadEventList();
        },
        child: Column(
          children: [
            events.when(data: (events) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          events.isEmpty
                              ? EventTextConstants.noEvent
                              : EventTextConstants.eventList,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 205, 205, 205))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 106,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: events.length + 2,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () {
                                pageNotifier.setEventPage(EventPage.addEvent);
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, top: 20, left: 40, right: 40),
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white,
                                          Colors.grey.shade100,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(3, 3),
                                        )
                                      ]),
                                  child: Center(
                                      child: HeroIcon(
                                    HeroIcons.plus,
                                    size: 40,
                                    color: Colors.grey.shade500,
                                  ))),
                            );
                          } else if (index == events.length + 1) {
                            return Container(
                              height: 80,
                            );
                          }
                          return EventUi(event: events[index - 1]);
                        }),
                  ),
                ],
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }, error: (error, stack) {
              return Center(
                child: Text("Error $error"),
              );
            })
          ],
        ),
      ),
    );
  }
}
