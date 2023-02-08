import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/providers/event_provider.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/functions.dart';

class EventUi extends ConsumerWidget {
  final Event event;
  final bool isDetailPage, isAdmin;
  final Function() onEdit, onConfirm, onDecline, onCopy, onInfo;
  const EventUi(
      {Key? key,
      required this.event,
      required this.isDetailPage,
      required this.isAdmin,
      required this.onEdit,
      required this.onConfirm,
      required this.onDecline,
      required this.onInfo,
      required this.onCopy})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final pageNotifier = ref.watch(eventPageProvider.notifier);
    final eventListNotifier = ref.watch(eventListProvider.notifier);
    final eventNotifier = ref.watch(eventProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final textColor =
        event.start.compareTo(now) <= 0 ? Colors.white : Colors.black;

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (!isDetailPage || isAdmin) {
            onInfo();
          }
        },
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: isDetailPage ? 20 : 40.0, vertical: 15),
            width: 300,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: event.end.compareTo(now) < 0
                      ? [
                          Colors.grey.shade700,
                          Colors.grey.shade800,
                        ]
                      : event.start.compareTo(now) <= 0
                          ? [
                              ColorConstants.gradient1,
                              ColorConstants.gradient2,
                            ]
                          : [
                              Colors.white,
                              Colors.grey.shade100,
                            ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: event.end.compareTo(now) < 0
                        ? Colors.black.withOpacity(0.2)
                        : event.start.compareTo(now) <= 0
                            ? ColorConstants.gradient2.withOpacity(0.2)
                            : Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(3, 3),
                  )
                ]),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
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
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (!isDetailPage)
                            GestureDetector(
                              onTap: () {
                                eventNotifier.setEvent(event);
                                pageNotifier.setEventPage(
                                    EventPage.eventDetailfromModuleFromMain);
                              },
                              child: HeroIcon(
                                HeroIcons.informationCircle,
                                color: textColor,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        formatRecurrenceRule(event.start, event.end,
                            event.recurrenceRule, event.allDay),
                        style: TextStyle(
                            color: textColor.withOpacity(0.7), fontSize: 13),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event.location,
                            style: TextStyle(color: textColor, fontSize: 15),
                          ),
                          Text(
                            event.organizer,
                            style: TextStyle(color: textColor, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        event.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: textColor.withOpacity(0.7), fontSize: 13),
                      ),
                      if (!isDetailPage)
                        Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      eventNotifier.setEvent(event);
                                      pageNotifier.setEventPage(
                                          EventPage.addEditEventFromMain);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                          color: event.end.compareTo(now) < 0
                                              ? Colors.grey.shade700
                                              : event.start.compareTo(now) <= 0
                                                  ? ColorConstants.gradient1
                                                  : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: event.end.compareTo(now) <
                                                      0
                                                  ? Colors.grey.shade700
                                                  : event.start
                                                              .compareTo(now) <=
                                                          0
                                                      ? ColorConstants.gradient1
                                                      : Colors.grey.shade300)),
                                      child: Center(
                                        child: Text(
                                          EventTextConstants.edit,
                                          style: TextStyle(
                                              color: textColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomDialogBox(
                                              descriptions: EventTextConstants
                                                  .deletingEvent,
                                              onYes: () async {
                                                final value =
                                                    await eventListNotifier
                                                        .deleteEvent(event);
                                                if (value) {
                                                  displayToastWithContext(
                                                      TypeMsg.msg,
                                                      EventTextConstants
                                                          .deletedEvent);
                                                } else {
                                                  displayToastWithContext(
                                                      TypeMsg.error,
                                                      EventTextConstants
                                                          .deletingError);
                                                }
                                              },
                                              title:
                                                  EventTextConstants.deleting,
                                            );
                                          });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                          color: event.end.compareTo(now) < 0
                                              ? Colors.grey.shade700
                                              : event.start.compareTo(now) <= 0
                                                  ? ColorConstants.gradient1
                                                  : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: event.end.compareTo(now) <
                                                      0
                                                  ? Colors.grey.shade700
                                                  : event.start
                                                              .compareTo(now) <=
                                                          0
                                                      ? ColorConstants.gradient1
                                                      : Colors.grey.shade300)),
                                      child: Center(
                                        child: Text(
                                          EventTextConstants.delete,
                                          style: TextStyle(
                                              color: textColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      if (isAdmin)
                        Column(children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: onEdit,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(2, 3))
                                    ],
                                  ),
                                  child: const HeroIcon(HeroIcons.pencil,
                                      color: Colors.black),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: onCopy,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(2, 3))
                                    ],
                                  ),
                                  child: const HeroIcon(
                                      HeroIcons.documentDuplicate,
                                      color: Colors.white),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  if (event.decision != Decision.approved) {
                                    onConfirm();
                                  }
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: isAdmin
                                            ? event.decision ==
                                                    Decision.approved
                                                ? Colors.black
                                                : Colors.transparent
                                            : Colors.transparent,
                                        width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(2, 3))
                                    ],
                                  ),
                                  child: const HeroIcon(HeroIcons.check,
                                      color: Colors.black),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  if (event.decision != Decision.declined) {
                                    onDecline();
                                  }
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: isAdmin
                                            ? event.decision ==
                                                    Decision.declined
                                                ? Colors.white
                                                : Colors.transparent
                                            : Colors.transparent,
                                        width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(2, 3))
                                    ],
                                  ),
                                  child: const HeroIcon(HeroIcons.xMark,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ]),
                    ]))));
  }
}
