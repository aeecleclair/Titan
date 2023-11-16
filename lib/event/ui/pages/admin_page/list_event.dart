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
import 'package:myecl/event/ui/components/event_ui.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ListEvent extends HookConsumerWidget {
  final List<Event> events;
  final bool canToggle;
  final String title;
  const ListEvent(
      {super.key,
      required this.events,
      required this.title,
      this.canToggle = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNotifier = ref.watch(eventProvider.notifier);
    final eventListNotifier = ref.watch(eventListProvider.notifier);
    final confirmedEventListNotifier =
        ref.watch(confirmedEventListProvider.notifier);
    final incomingEvents =
        events.where((e) => e.start.isAfter(DateTime.now())).toList();

    final toggle = useState(!canToggle);
    if (incomingEvents.isEmpty) {
      return const SizedBox();
    }
    return Column(children: [
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
                AlignLeftText(
                  "$title${incomingEvents.length > 1 ? "s" : ""} (${incomingEvents.length})",
                  color: Colors.grey,
                ),
                if (canToggle)
                  HeroIcon(
                    toggle.value ? HeroIcons.chevronUp : HeroIcons.chevronDown,
                    color: Colors.grey,
                    size: 30,
                  ),
              ],
            ),
          )),
      if (toggle.value)
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: HorizontalListView.builder(
              height: 235,
              items: incomingEvents,
              itemBuilder: (context, e, i) => EventUi(
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
                                descriptions: BookingTextConstants.confirmBooking,
                                onYes: () async {
                                  await tokenExpireWrapper(ref, () async {
                                    eventListNotifier
                                        .toggleConfirmed(e, Decision.approved)
                                        .then((value) {
                                      if (value) {
                                        confirmedEventListNotifier.addEvent(e);
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
                                descriptions: BookingTextConstants.declineBooking,
                                onYes: () async {
                                  await tokenExpireWrapper(ref, () async {
                                    eventListNotifier
                                        .toggleConfirmed(e, Decision.declined)
                                        .then((value) {
                                      if (value) {
                                        confirmedEventListNotifier.deleteEvent(e);
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
        ),
    ]);
  }
}
