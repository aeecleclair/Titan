import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/event/adapters/event.dart';
import 'package:myecl/event/providers/confirmed_event_list_provider.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/providers/event_provider.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/event/ui/components/event_ui.dart';
import 'package:myecl/generated/openapi.enums.swagger.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ListEvent extends HookConsumerWidget {
  final List<EventReturn> events;
  final bool canToggle;
  final String title;
  final bool isHistory;
  const ListEvent({
    super.key,
    required this.events,
    required this.title,
    this.canToggle = true,
    this.isHistory = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNotifier = ref.watch(eventProvider.notifier);
    final eventListNotifier = ref.watch(eventListProvider.notifier);
    final confirmedEventListNotifier =
        ref.watch(confirmedEventListProvider.notifier);
    final filteredEvents = isHistory
        ? events.where((e) => e.end.isBefore(DateTime.now())).toList()
        : events.where((e) => e.end.isAfter(DateTime.now())).toList();
    filteredEvents
        .sort((a, b) => (isHistory ? -1 : 1) * a.start.compareTo(b.start));

    final toggle = useState(!canToggle);
    if (filteredEvents.isEmpty) {
      return const SizedBox();
    }
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
                AlignLeftText(
                  "$title${filteredEvents.length > 1 ? "s" : ""} (${filteredEvents.length})",
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
          ),
        ),
        if (toggle.value)
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: HorizontalListView.builder(
              height: 235,
              items: filteredEvents,
              itemBuilder: (context, e, i) => EventUi(
                event: e,
                isDetailPage: true,
                isAdmin: true,
                onEdit: () {
                  eventNotifier.setEvent(e);
                  QR.to(
                    EventRouter.root + EventRouter.admin + EventRouter.addEdit,
                  );
                },
                onInfo: () {
                  eventNotifier.setEvent(e);
                  QR.to(
                    EventRouter.root + EventRouter.admin + EventRouter.detail,
                  );
                },
                onConfirm: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialogBox(
                        title: BookingTextConstants.confirm,
                        descriptions: BookingTextConstants.confirmBooking,
                        onYes: () async {
                          eventListNotifier
                              .toggleConfirmed(
                            e.copyWith(
                              decision: Decision.approved,
                            ),
                          )
                              .then((value) {
                            if (value) {
                              confirmedEventListNotifier
                                  .addEvent(e.toEventComplete());
                            }
                          });
                        },
                      );
                    },
                  );
                },
                onDecline: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialogBox(
                        title: BookingTextConstants.decline,
                        descriptions: BookingTextConstants.declineBooking,
                        onYes: () async {
                          eventListNotifier
                              .toggleConfirmed(
                            e.copyWith(
                              decision: Decision.declined,
                            ),
                          )
                              .then((value) {
                            if (value) {
                              confirmedEventListNotifier
                                  .deleteEvent(e.toEventComplete());
                            }
                          });
                        },
                      );
                    },
                  );
                },
                onCopy: () {
                  eventNotifier.setEvent(e.copyWith(id: ""));
                  QR.to(
                    EventRouter.root + EventRouter.admin + EventRouter.addEdit,
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
