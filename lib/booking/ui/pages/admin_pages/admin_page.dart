import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/booking/class/manager.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/manager_list_provider.dart';
import 'package:myecl/booking/providers/manager_id_provider.dart';
import 'package:myecl/booking/providers/manager_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/providers/room_provider.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/booking/ui/calendar.dart';
import 'package:myecl/booking/ui/pages/admin_pages/admin_chip.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomList = ref.watch(roomListProvider);
    final roomNotifier = ref.watch(roomProvider.notifier);
    final managerList = ref.watch(managerListProvider);
    final managerIdNotifier = ref.watch(managerIdProvider.notifier);
    final managerNotifier = ref.watch(managerProvider.notifier);
    final groupIdNotifier = ref.watch(groupIdProvider.notifier);
    return BookingTemplate(
      child: Refresher(
        onRefresh: () async {
          await ref.watch(bookingListProvider.notifier).loadBookings();
          await ref.watch(roomListProvider.notifier).loadRooms();
          await ref
              .watch(confirmedBookingListProvider.notifier)
              .loadConfirmedBooking();
        },
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height - 380,
              child: const Calendar(),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(BookingTextConstants.room,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 149, 149))),
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
                    GestureDetector(
                      onTap: () {
                        roomNotifier.setRoom(Room.empty());
                        managerIdNotifier.setId("");
                        QR.to(BookingRouter.root +
                            BookingRouter.admin +
                            BookingRouter.room);
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Chip(
                            label: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: HeroIcon(
                                HeroIcons.plus,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                            backgroundColor: Colors.grey.shade200,
                          )),
                    ),
                    ...data.map(
                      (e) => AdminChip(
                        label: capitalize(e.name),
                        selected: false,
                        onTap: () {
                          roomNotifier.setRoom(e);
                          managerIdNotifier.setId(e.managerId);
                          QR.to(BookingRouter.root +
                              BookingRouter.admin +
                              BookingRouter.room);
                        },
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(BookingTextConstants.manager,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 149, 149))),
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
                    GestureDetector(
                      onTap: () {
                        managerNotifier.setManager(Manager.empty());
                        groupIdNotifier.setId("");
                        QR.to(BookingRouter.root +
                            BookingRouter.admin +
                            BookingRouter.manager);
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Chip(
                            label: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: HeroIcon(
                                HeroIcons.plus,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                            backgroundColor: Colors.grey.shade200,
                          )),
                    ),
                    ...data.map(
                      (e) => AdminChip(
                        label: e.name,
                        selected: false,
                        onTap: () {
                          managerNotifier.setManager(e);
                          groupIdNotifier.setId(e.groupId);
                          QR.to(BookingRouter.root +
                              BookingRouter.admin +
                              BookingRouter.manager);
                        },
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
    );
  }
}
