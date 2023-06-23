import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/confirmed_event_list_provider.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/providers/event_provider.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/event/ui/event_ui.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/ui/web_list_view.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ListEvent extends HookConsumerWidget {
  final List<Event> events;
  final bool canToggle;
  final String title;
  const ListEvent({
    Key? key,
    required this.events,
    required this.title,
    this.canToggle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNotifier = ref.watch(eventProvider.notifier);
    final eventListNotifier = ref.watch(eventListProvider.notifier);
    final confirmedEventListNotifier =
        ref.watch(confirmedEventListProvider.notifier);
    final incomingEvents =
        events.where((e) => e.start.isAfter(DateTime.now())).toList();

    final toggle = useState(!canToggle);
    if (incomingEvents.isNotEmpty) {
      return Column(
        children: [
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (canToggle) {
                  toggle.value = !toggle.value;
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "$title${incomingEvents.length > 1 ? "s" : ""} (${incomingEvents.length})",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 149, 149, 149))),
                    ),
                    if (canToggle)
                      HeroIcon(
                        toggle.value
                            ? HeroIcons.chevronUp
                            : HeroIcons.chevronDown,
                        color: const Color.fromARGB(255, 149, 149, 149),
                        size: 30,
                      ),
                  ],
                ),
              )),
          if (toggle.value)
            SizedBox(
                height: 235,
                child: HorizontalListView(
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      ...incomingEvents.map((e) => EventUi(
                            event: e,
                            isDetailPage: true,
                            isAdmin: true,
                            onEdit: () {
                              eventNotifier.setEvent(e);
                              QR.to(EventRouter.root +
                                  EventRouter.admin +
                                  EventRouter.addEdit);
                            },
                            onInfo: () {
                              eventNotifier.setEvent(e);
                              QR.to(EventRouter.root +
                                  EventRouter.admin +
                                  EventRouter.detail);
                            },
                            onConfirm: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                        title: BookingTextConstants.confirm,
                                        descriptions:
                                            BookingTextConstants.confirmBooking,
                                        onYes: () async {
                                          await tokenExpireWrapper(ref,
                                              () async {
                                            eventListNotifier
                                                .toggleConfirmed(
                                                    e, Decision.approved)
                                                .then((value) {
                                              if (value) {
                                                confirmedEventListNotifier
                                                    .addEvent(e);
                                              }
                                            });
                                          });
                                        });
                                  });
                            },
                            onDecline: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                        title: BookingTextConstants.decline,
                                        descriptions:
                                            BookingTextConstants.declineBooking,
                                        onYes: () async {
                                          await tokenExpireWrapper(ref,
                                              () async {
                                            eventListNotifier
                                                .toggleConfirmed(
                                                    e, Decision.declined)
                                                .then((value) {
                                              if (value) {
                                                confirmedEventListNotifier
                                                    .deleteEvent(e);
                                              }
                                            });
                                          });
                                        });
                                  });
                            },
                            onCopy: () {
                              eventNotifier.setEvent(e.copyWith(id: ""));
                              QR.to(EventRouter.root +
                                  EventRouter.admin +
                                  EventRouter.addEdit);
                            },
                          )),
                      const SizedBox(width: 10),
                    ],
                  ),
                )),
          const SizedBox(height: 30),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
