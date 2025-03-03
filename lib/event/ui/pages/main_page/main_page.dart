import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/event/providers/event_provider.dart';
import 'package:myecl/event/providers/is_admin_provider.dart';
import 'package:myecl/event/providers/user_event_list_provider.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/event/ui/event.dart';
import 'package:myecl/event/ui/components/event_ui.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/ui/layouts/column_refresher.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EventMainPage extends HookConsumerWidget {
  const EventMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isAdmin = ref.watch(isEventAdminProvider);
    final eventNotifier = ref.watch(eventProvider.notifier);
    final eventListNotifier =
        ref.watch(eventEventListProvider(user.id).notifier);
    final events = ref.watch(eventEventListProvider(user.id));
    return EventTemplate(
      child: AsyncChild(
        value: events,
        builder: (context, eventList) {
          eventList.sort((a, b) => b.start.compareTo(a.start));
          return ColumnRefresher(
            onRefresh: () async {
              await eventListNotifier.loadConfirmedEvent(user.id);
            },
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
                          color: Colors.grey,
                        ),
                      ),
                      if (isAdmin)
                        AdminButton(
                          onTap: () {
                            QR.to(EventRouter.root + EventRouter.admin);
                          },
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  eventNotifier.setEvent(EmptyModels.empty<EventReturn>());
                  QR.to(EventRouter.root + EventRouter.addEdit);
                },
                child: CardLayout(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                    top: 20,
                    left: 40,
                    right: 40,
                  ),
                  width: double.infinity,
                  height: 100,
                  color: Colors.white,
                  child: Center(
                    child: HeroIcon(
                      HeroIcons.plus,
                      size: 40,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
              ...eventList.map(
                (event) => EventUi(
                  event: event,
                ),
              ),
              const SizedBox(height: 80),
            ],
          );
        },
      ),
    );
  }
}
