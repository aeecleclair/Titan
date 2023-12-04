import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/booking/providers/admin_booking_list_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/manager_list_provider.dart';
import 'package:myecl/booking/providers/manager_id_provider.dart';
import 'package:myecl/booking/providers/manager_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/providers/room_provider.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/booking/ui/pages/admin_pages/admin_chip.dart';
import 'package:myecl/booking/ui/components/list_booking.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/widgets/calendar.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomList = ref.watch(roomListProvider);
    final room = ref.watch(roomProvider);
    final roomNotifier = ref.watch(roomProvider.notifier);
    final bookings = ref.watch(adminBookingListProvider);
    final managerNotifier = ref.watch(managerProvider.notifier);
    final managerIdNotifier = ref.watch(managerIdProvider.notifier);
    final managerList = ref.watch(managerListProvider);
    final groupIdNotifier = ref.watch(groupIdProvider.notifier);
    final List<BookingReturnApplicant> pendingBookings = [],
        confirmedBookings = [],
        canceledBookings = [];
    bookings.maybeWhen(
        data: (
          bookings,
        ) {
          for (BookingReturnApplicant b in bookings) {
            switch (b.decision) {
              case AppUtilsTypesBookingTypeDecision .approved:
                confirmedBookings.add(b);
                break;
              case AppUtilsTypesBookingTypeDecision .declined:
                canceledBookings.add(b);
                break;
              case AppUtilsTypesBookingTypeDecision .pending:
                pendingBookings.add(b);
                break;
              case AppUtilsTypesBookingTypeDecision.swaggerGeneratedUnknown:
                break;
            }
          }
          confirmedBookings.sort((a, b) => b.start.compareTo(a.start));
          canceledBookings.sort((a, b) => b.start.compareTo(a.start));
          pendingBookings.sort((a, b) => b.start.compareTo(a.start));
        },
        orElse: () {});
    List<Appointment> appointments = <Appointment>[];
    confirmedBookings.map((e) {
      if (e.recurrenceRule != "") {
        final dates = getDateInRecurrence(e.recurrenceRule!, e.start);
        dates.map((data) {
          appointments.add(Appointment(
            startTime: combineDate(data, e.start),
            endTime: combineDate(data, e.end),
            subject: '${e.room.name} - ${e.reason}',
            isAllDay: false,
            startTimeZone: "Europe/Paris",
            endTimeZone: "Europe/Paris",
            notes: e.note,
            color: generateColor(e.room.name),
          ));
        }).toList();
      } else {
        appointments.add(Appointment(
          startTime: e.start,
          endTime: e.end,
          subject: '${e.room.name} - ${e.reason}',
          isAllDay: false,
          startTimeZone: "Europe/Paris",
          endTimeZone: "Europe/Paris",
          notes: e.note,
          color: generateColor(e.room.name),
        ));
      }
    }).toList();
    return BookingTemplate(
      child: Refresher(
        onRefresh: () async {
          await ref.watch(adminBookingListProvider.notifier).loadBookings();
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
                child: Calendar(
                    items: bookings,
                    dataSource: AppointmentDataSource(appointments))),
            const SizedBox(height: 30),
            if (pendingBookings.isEmpty &&
                confirmedBookings.isEmpty &&
                canceledBookings.isEmpty)
              const Center(
                child: Text(BookingTextConstants.noCurrentBooking,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ListBooking(
              title: BookingTextConstants.pending,
              bookings: pendingBookings,
              canToggle: false,
            ),
            ListBooking(
              title: BookingTextConstants.confirmed,
              bookings: confirmedBookings,
            ),
            ListBooking(
              title: BookingTextConstants.declined,
              bookings: canceledBookings,
            ),
            const SizedBox(height: 10),
            const AlignLeftText(
              BookingTextConstants.room,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              color: Colors.grey,
            ),
            const SizedBox(height: 30),
            AsyncChild(
              value: roomList,
              builder: (context, rooms) => HorizontalListView.builder(
                height: 40,
                items: rooms,
                firstChild: ItemChip(
                  onTap: () {
                    roomNotifier.setRoom(RoomComplete.fromJson({}));
                    managerIdNotifier.setId("");
                    QR.to(BookingRouter.root +
                        BookingRouter.admin +
                        BookingRouter.room);
                  },
                  child: const HeroIcon(
                    HeroIcons.plus,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                itemBuilder: (context, r, index) {
                  final selected = room.id == r.id;
                  return ItemChip(
                    selected: selected,
                    onTap: () {
                      roomNotifier.setRoom(r);
                      managerIdNotifier.setId(r.managerId);
                      QR.to(BookingRouter.root +
                          BookingRouter.admin +
                          BookingRouter.room);
                    },
                    child: Text(
                      capitalize(r.name),
                      style: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
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
            roomList.when(
              data: (data) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        roomNotifier.setRoom(RoomComplete.fromJson({}));
                        managerIdNotifier.setId("");
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
                        label: capitalize(e.name),
                        selected: false,
                        onTap: () {
                          roomNotifier.setRoom(e);
                          managerIdNotifier.setId(e.managerId);
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
                        managerNotifier.setManager(Manager.fromJson({}));
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
