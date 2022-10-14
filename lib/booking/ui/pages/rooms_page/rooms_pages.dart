import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/pages/rooms_page/room_ui.dart';
import 'package:myecl/booking/ui/refresh_indicator.dart';

class RoomsPage extends HookConsumerWidget {
  const RoomsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomList = ref.watch(roomListProvider);
    final roomListNotifier = ref.watch(roomListProvider.notifier);
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    return BookingRefresher(
        onRefresh: () async {
          await roomListNotifier.loadRooms();
        },
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            child: Column(children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  pageNotifier.setBookingPage(BookingPage.addRoom);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: BookingColorConstants.darkBlue,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: BookingColorConstants.darkBlue.withOpacity(0.15),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      BookingTextConstants.addRoom,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(BookingTextConstants.registeredRooms,
                  style: TextStyle(
                      fontSize: 18, color: BookingColorConstants.darkBlue)),
              const SizedBox(height: 20),
              roomList.when(data: (rooms) {
                if (rooms.isEmpty) {
                  return const Center(
                    child: Text(BookingTextConstants.noRoomFoundError,
                        style: TextStyle(
                            fontSize: 12,
                            color: BookingColorConstants.darkBlue)),
                  );
                }
                return Column(
                    children: rooms.map((e) => RoomUi(r: e)).toList());
              }, error: (Object error, StackTrace? stackTrace) {
                return Text(error.toString());
              }, loading: () {
                return const Center(
                    child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(BookingColorConstants.darkBlue),
                ));
              })
            ])));
  }
}
