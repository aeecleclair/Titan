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
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EventMainPage extends HookConsumerWidget {
  const EventMainPage({super.key});

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
        child: AsyncChild(
          value: events,
          builder: (context, eventList) {
            eventList.sort((a, b) => b.start.compareTo(a.start));
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
                            eventList.isEmpty
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
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 106,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: eventList.length + 2,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return GestureDetector(
                            onTap: () {
                              eventNotifier.setEvent(Event.empty());
                              QR.to(EventRouter.root + EventRouter.addEdit);
                            },
                            child: CardLayout(
                                margin: const EdgeInsets.only(
                                    bottom: 10, top: 20, left: 40, right: 40),
                                width: double.infinity,
                                height: 100,
                                color: Colors.white,
                                child: Center(
                                    child: HeroIcon(
                                  HeroIcons.plus,
                                  size: 40,
                                  color: Colors.grey.shade500,
                                ))),
                          );
                        } else if (index == eventList.length + 1) {
                          return const SizedBox(height: 80);
                        }
                        return EventUi(event: eventList[index - 1]);
                      }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
