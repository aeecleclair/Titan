import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_provider.dart';
import 'package:myecl/event/providers/is_admin.dart';
import 'package:myecl/event/providers/user_event_list_provider.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/event/ui/event.dart';
import 'package:myecl/event/ui/components/event_ui.dart';
import 'package:myecl/tools/ui/admin_button.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EventMainPage extends HookConsumerWidget {
  const EventMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isEventAdminProvider);
    final eventNotifier = ref.watch(eventProvider.notifier);
    final eventListNotifier = ref.watch(eventEventListProvider.notifier);
    final events = ref.watch(eventEventListProvider);
    return EventTemplate(
      child: Refresher(
        onRefresh: () async {
          await eventListNotifier.loadConfirmedEvent();
        },
        child: Column(
          children: [
            events.when(data: (events) {
              events.sort((a, b) => b.start.compareTo(a.start));
              return Column(
                children: [
                const SizedBox(height: 40),
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
                            AdminButton(
                              onTap: () {
                                QR.to(EventRouter.root + EventRouter.admin);
                              },
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
                                QR.to(EventRouter.root + EventRouter.addEdit);
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
                child: CircularProgressIndicator(),
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
