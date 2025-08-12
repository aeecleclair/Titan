import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/group_id_provider.dart';
import 'package:titan/booking/class/manager.dart';
import 'package:titan/service/class/room.dart';
import 'package:titan/booking/providers/confirmed_booking_list_provider.dart';
import 'package:titan/booking/providers/manager_list_provider.dart';
import 'package:titan/booking/providers/manager_id_provider.dart';
import 'package:titan/booking/providers/manager_provider.dart';
import 'package:titan/service/providers/room_list_provider.dart';
import 'package:titan/booking/providers/room_provider.dart';
import 'package:titan/booking/router.dart';
import 'package:titan/booking/ui/booking.dart';
import 'package:titan/booking/ui/calendar/calendar.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double minCalendarHeight = 400;
    const double sumOfHeightOfOthersWidgets = 282;
    final roomList = ref.watch(roomListProvider);
    final roomNotifier = ref.watch(roomProvider.notifier);
    final managerNotifier = ref.watch(managerProvider.notifier);
    final managerIdNotifier = ref.watch(managerIdProvider.notifier);
    final managerList = ref.watch(managerListProvider);
    final groupIdNotifier = ref.watch(groupIdProvider.notifier);
    return BookingTemplate(
      child: LayoutBuilder(
        builder: (context, constraints) => Refresher(
          controller: ScrollController(),
          onRefresh: () async {
            await ref.watch(roomListProvider.notifier).loadRooms();
            await ref
                .watch(confirmedBookingListProvider.notifier)
                .loadConfirmedBooking();
          },
          child: SizedBox(
            height: max(
              constraints.maxHeight,
              minCalendarHeight + sumOfHeightOfOthersWidgets,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Expanded(child: Calendar(isManagerPage: false)),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.bookingRoom,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 149, 149),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                roomList.when(
                  data: (List<Room> data) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 15),
                        ItemChip(
                          onTap: () {
                            roomNotifier.setRoom(Room.empty());
                            managerIdNotifier.setId("");
                            QR.to(
                              BookingRouter.root +
                                  BookingRouter.admin +
                                  BookingRouter.room,
                            );
                          },
                          child: const HeroIcon(
                            HeroIcons.plus,
                            color: Colors.black,
                          ),
                        ),
                        ...data.map(
                          (e) => ItemChip(
                            onTap: () {
                              roomNotifier.setRoom(e);
                              managerIdNotifier.setId(e.managerId);
                              QR.to(
                                BookingRouter.root +
                                    BookingRouter.admin +
                                    BookingRouter.room,
                              );
                            },
                            child: Text(
                              capitalize(e.name),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                  error: (Object error, StackTrace? stackTrace) {
                    return Center(child: Text('Error $error'));
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.bookingManager,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 149, 149),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                managerList.when(
                  data: (List<Manager> data) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 15),
                        ItemChip(
                          onTap: () {
                            managerNotifier.setManager(Manager.empty());
                            groupIdNotifier.setId("");
                            QR.to(
                              BookingRouter.root +
                                  BookingRouter.admin +
                                  BookingRouter.manager,
                            );
                          },
                          child: const HeroIcon(
                            HeroIcons.plus,
                            color: Colors.black,
                          ),
                        ),
                        ...data.map(
                          (e) => ItemChip(
                            onTap: () {
                              managerNotifier.setManager(e);
                              groupIdNotifier.setId(e.groupId);
                              QR.to(
                                BookingRouter.root +
                                    BookingRouter.admin +
                                    BookingRouter.manager,
                              );
                            },
                            child: Text(
                              e.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                  error: (Object error, StackTrace? stackTrace) {
                    return Center(child: Text('Error $error'));
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
