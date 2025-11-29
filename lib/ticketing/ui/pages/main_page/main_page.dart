import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/advert/providers/announcer_provider.dart';
import 'package:titan/booking/providers/is_admin_provider.dart';
import 'package:titan/ticketing/ui/components/event_card.dart';
import 'package:titan/ticketing/ui/ticketing.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/tools/ui/layouts/column_refresher.dart';
import 'package:titan/ticketing/router.dart';
import 'package:titan/ticketing/providers/is_ticketing_admin_provider.dart';
import 'package:titan/ticketing/providers/event_list_provider.dart';
import 'package:titan/ticketing/providers/event_provider.dart';
import 'package:titan/ticketing/ui/pages/main_page/main_page.dart';
import 'package:titan/ticketing/ui/components/announcer_bar.dart';
import 'package:titan/ticketing/tools/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TicketingMainPage extends HookConsumerWidget {
  const TicketingMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isEventAdmin = ref.watch(isEventAdminProvider);
    final isAdmin = ref.watch(isAdminProvider);

    final eventNotifier = ref.watch(eventProvider.notifier);
    final eventList = ref.watch(eventListProvider);
    final eventListNotifier = ref.watch(eventListProvider.notifier);
    final selected = ref.watch(announcerProvider);
    final selectedNotifier = ref.watch(announcerProvider.notifier);

    double width = 300;
    double height = 300;
    double imageHeight = 175;
    double maxHeight = MediaQuery.of(context).size.height - 344;

    return TicketingTemplate(
      child: Stack(
        children: [
          AsyncChild(
            value: eventList,
            builder: (context, eventData) {
              final sortedEventData = eventData
                  .sortedBy((element) => element.date)
                  .reversed;
              final filteredSortedEventData = sortedEventData.where(
                (event) =>
                    selected
                        .where((e) => event.announcer.name == e.name)
                        .isNotEmpty ||
                    selected.isEmpty,
              );
              return ColumnRefresher(
                onRefresh: () async {
                  await eventListNotifier.loadEvents();
                },
                children: [
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        if (isAdmin)
                          AdminButton(
                            onTap: () {
                              QR.to(
                                TicketingRouter.root + TicketingRouter.admin,
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const AnnouncerBar(
                    useUserAnnouncers: false,
                    multipleSelect: true,
                  ),
                  const SizedBox(height: 20),
                  ...filteredSortedEventData.map(
                    (event) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: EventCard(
                        onTap: () {
                          eventNotifier.setEvent(event);
                          QR.to(TicketingRouter.root + TicketingRouter.admin);
                        },
                        event: event,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
//     SafeArea(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           TopBar(title: 'Event', root: TicketingRouter.root),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: width,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [

//                         // if (isEventAdmin)
//                         //   AdminButton(
//                         //     onTap: () {
//                         //       QR.to(
//                         //         TicketingRouter.root +
//                         //             TicketingRouter.addEditMember,
//                         //       );
//                         //     },
//                         //     text: EventTextConstants.management,
//                         //   ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             EventTextConstants.news,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
