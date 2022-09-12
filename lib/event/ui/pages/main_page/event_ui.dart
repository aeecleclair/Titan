import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/providers/event_provider.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/event/tools/dialog.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class EventUi extends ConsumerWidget {
  final Event e;
  const EventUi({Key? key, required this.e})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(eventPageProvider.notifier);
    final eventListNotfier = ref.watch(eventListProvider.notifier);
    final eventNotifier = ref.watch(eventProvider.notifier);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        eventNotifier.setEvent(e);
        pageNotifier.setEventPage(EventPage.eventDetailfromModule);
      },
      child: Container(
          height: 55,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 20,
              ),
              Expanded(
                child: Text(
                  e.name,
                  style: const TextStyle(fontSize: 15,
                  fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 15,
                  ),
                  Container(
                    width: 80,
                    alignment: Alignment.centerRight,
                    child: Text(
                      e.location,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    width: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        gradient:  LinearGradient(colors: const [
                          EventColorConstants.blueGradient1,
                          EventColorConstants.blueGradient2
                        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  EventColorConstants.blueGradient1
                                  .withOpacity(0.4),
                              offset: const Offset(2, 3),
                              blurRadius: 5)
                        ],
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const HeroIcon(
                        HeroIcons.pencilAlt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // final productModif =
                      //     ref.watch(modifiedProductProvider.notifier);
                      // final pageNotifier = ref.watch(amapPageProvider.notifier);
                      // productModif.setModifiedProduct(i);
                      // pageNotifier.setAmapPage(AmapPage.modif);
                    },
                  ),
                  Container(
                    width: 15,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        gradient:  LinearGradient(colors: const [
                          EventColorConstants.redGradient1,
                          EventColorConstants.redGradient2
                        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                              color: EventColorConstants.redGradient2
                                  .withOpacity(0.4),
                              offset: const Offset(2, 3),
                              blurRadius: 5)
                        ],
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const HeroIcon(
                        HeroIcons.trash,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => EventDialog(
                              descriptions: EventTextConstants.deletingEvent,
                              title: EventTextConstants.deleting,
                              onYes: () async {
                                tokenExpireWrapper(ref, () async {
                                  await eventListNotfier.deleteEvent(e);
                                  displayEventToast(context, TypeMsg.msg,
                                      EventTextConstants.deletedEvent);
                                });
                              }));
                    },
                  )
                ],
              ),
              Container(
                width: 15,
              ),
            ],
          )),
    );
  }
}
