import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/confirmed_event_list_provider.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/providers/event_provider.dart';
import 'package:myecl/event/providers/is_admin.dart';
import 'package:myecl/event/providers/user_event_list_provider.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/event/ui/event_ui.dart';
import 'package:myecl/tools/ui/refresher.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isEventAdmin);
    final pageNotifier = ref.watch(eventPageProvider.notifier);
    final eventNotifier = ref.watch(eventProvider.notifier);
    final eventListNotifier = ref.watch(eventEventListProvider.notifier);
    final events = ref.watch(eventEventListProvider);
    return Expanded(
      child: Refresher(
        onRefresh: () async {
          await eventListNotifier.loadConfirmedEvent();
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              events.isEmpty
                                  ? EventTextConstants.noEvent
                                  : EventTextConstants.myEvents,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 149, 149, 149))),
                          if (isAdmin)
                            GestureDetector(
                              onTap: () {
                                pageNotifier.setEventPage(EventPage.admin);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5))
                                    ]),
                                child: Row(
                                  children: const [
                                    HeroIcon(HeroIcons.userGroup,
                                        color: Colors.white, size: 20),
                                    SizedBox(width: 10),
                                    Text("Admin",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
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
                                eventNotifier.setEvent(Event.empty());
                                pageNotifier.setEventPage(
                                    EventPage.addEditEventFromMain);
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
                          return EventUi(
                            event: events[index - 1],
                            isAdmin: false,
                            isDetailPage: false,
                            onConfirm: () {},
                            onCopy: () {},
                            onDecline: () {},
                            onEdit: () {},
                            onInfo: () {},
                          );
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
