import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/event/class/event.dart';
import 'package:titan/event/providers/event_provider.dart';
import 'package:titan/event/providers/user_event_list_provider.dart';
import 'package:titan/event/router.dart';
import 'package:titan/event/tools/constants.dart';
import 'package:titan/event/tools/functions.dart';
import 'package:titan/event/ui/components/edit_delete_button.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EventUi extends ConsumerWidget {
  final Event event;
  final bool isDetailPage, isAdmin;
  final Function()? onEdit, onConfirm, onDecline, onCopy, onInfo;
  const EventUi({
    super.key,
    required this.event,
    this.isDetailPage = false,
    this.isAdmin = false,
    this.onEdit,
    this.onConfirm,
    this.onDecline,
    this.onInfo,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final eventListNotifier = ref.watch(eventEventListProvider.notifier);
    final eventNotifier = ref.watch(eventProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final textColor = event.start.compareTo(now) <= 0
        ? Colors.white
        : Colors.black;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!isDetailPage || isAdmin) {
          onInfo?.call();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: isDetailPage ? 20 : 40.0,
          vertical: 10,
        ),
        width: 250,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: event.end.compareTo(now) < 0
                ? [Colors.grey.shade700, Colors.grey.shade800]
                : event.start.compareTo(now) <= 0
                ? [ColorConstants.gradient1, ColorConstants.gradient2]
                : [Colors.white, Colors.white],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: event.end.compareTo(now) < 0
                  ? Colors.black.withValues(alpha: 0.2)
                  : event.start.compareTo(now) <= 0
                  ? ColorConstants.gradient2.withValues(alpha: 0.2)
                  : Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      event.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (!isDetailPage)
                    GestureDetector(
                      onTap: () {
                        eventNotifier.setEvent(event);
                        QR.to(EventRouter.root + EventRouter.detail);
                      },
                      child: HeroIcon(
                        HeroIcons.informationCircle,
                        color: textColor,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 7),
              Container(
                constraints: const BoxConstraints(maxHeight: 38),
                child: Scrollbar(
                  radius: const Radius.circular(8),
                  child: SingleChildScrollView(
                    child: Text(
                      formatRecurrenceRule(
                        event.start,
                        event.end,
                        event.recurrenceRule,
                        event.allDay,
                      ),
                      style: TextStyle(
                        color: textColor.withValues(alpha: 0.7),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      event.location,
                      maxLines: 1,
                      style: TextStyle(color: textColor, fontSize: 15),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    event.organizer,
                    style: TextStyle(color: textColor, fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                event.description
                        .split("\n")
                        .sublist(
                          0,
                          event.description.split("\n").length > 1 ? 2 : 1,
                        )
                        .join("\n") +
                    (event.description.split("\n").length > 1 ? "..." : ""),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor.withValues(alpha: 0.7),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.center,
                child: Text(
                  decisionToString(event.decision),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (!isDetailPage)
                Column(
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              eventNotifier.setEvent(event);
                              QR.to(EventRouter.root + EventRouter.addEdit);
                            },
                            child: EditDeleteButton(
                              backGroundColor: event.end.compareTo(now) < 0
                                  ? Colors.grey.shade700
                                  : event.start.compareTo(now) <= 0
                                  ? ColorConstants.gradient1
                                  : Colors.white,
                              borderColor: event.end.compareTo(now) < 0
                                  ? Colors.grey.shade700
                                  : event.start.compareTo(now) <= 0
                                  ? ColorConstants.gradient1
                                  : Colors.grey.shade300,
                              child: Center(
                                child: Text(
                                  EventTextConstants.edit,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: WaitingButton(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    descriptions:
                                        EventTextConstants.deletingEvent,
                                    onYes: () async {
                                      final value = await eventListNotifier
                                          .deleteEvent(event);
                                      if (value) {
                                        displayToastWithContext(
                                          TypeMsg.msg,
                                          EventTextConstants.deletedEvent,
                                        );
                                      } else {
                                        displayToastWithContext(
                                          TypeMsg.error,
                                          EventTextConstants.deletingError,
                                        );
                                      }
                                    },
                                    title: EventTextConstants.deleting,
                                  );
                                },
                              );
                            },
                            builder: (child) => EditDeleteButton(
                              backGroundColor: event.end.compareTo(now) < 0
                                  ? Colors.grey.shade700
                                  : event.start.compareTo(now) <= 0
                                  ? ColorConstants.gradient1
                                  : Colors.white,
                              borderColor: event.end.compareTo(now) < 0
                                  ? Colors.grey.shade700
                                  : event.start.compareTo(now) <= 0
                                  ? ColorConstants.gradient1
                                  : Colors.grey.shade300,
                              child: child,
                            ),
                            child: Center(
                              child: Text(
                                EventTextConstants.delete,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              if (isAdmin) const Spacer(),
              if (isAdmin)
                Row(
                  children: [
                    GestureDetector(
                      onTap: onEdit,
                      child: const CardButton(
                        child: HeroIcon(HeroIcons.pencil, color: Colors.black),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onCopy,
                      child: const CardButton(
                        color: Colors.black,
                        child: HeroIcon(
                          HeroIcons.documentDuplicate,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (event.decision != Decision.approved) {
                          onConfirm?.call();
                        }
                      },
                      child: CardButton(
                        borderColor: isAdmin
                            ? event.decision == Decision.approved
                                  ? Colors.black
                                  : Colors.transparent
                            : Colors.transparent,
                        child: const HeroIcon(
                          HeroIcons.check,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (event.decision != Decision.declined) {
                          onDecline?.call();
                        }
                      },
                      child: CardButton(
                        color: Colors.black,
                        borderColor: isAdmin
                            ? event.decision == Decision.declined
                                  ? Colors.white
                                  : Colors.transparent
                            : Colors.transparent,
                        child: const HeroIcon(
                          HeroIcons.xMark,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
