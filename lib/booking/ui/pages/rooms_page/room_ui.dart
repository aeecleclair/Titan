import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/providers/room_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/drawer/tools/dialog.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class RoomUi extends HookConsumerWidget {
  final Room r;
  const RoomUi({Key? key, required this.r}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    final roomListNotifier = ref.watch(roomListProvider.notifier);
    final roomNotifier = ref.watch(roomProvider.notifier);
    return Container(
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
                r.name,
                style: const TextStyle(fontSize: 18, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 20,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      gradient:  const LinearGradient(colors: [
                        Colors.white,
                        Color.fromARGB(255, 175, 216, 226)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 175, 216, 226)
                                .withOpacity(0.4),
                            offset: const Offset(2, 3),
                            blurRadius: 5)
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const HeroIcon(
                      HeroIcons.pencilSquare,
                      size: 20,
                      color: BookingColorConstants.darkBlue,
                    ),
                  ),
                  onTap: () {
                    roomNotifier.setRoom(r);
                    pageNotifier.setBookingPage(BookingPage.editRoom);
                  },
                ),
                Container(
                  width: 15,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration:  const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        BookingColorConstants.darkBlue,
                        BookingColorConstants.lightBlue
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        builder: (BuildContext context) => BookingDialog(
                            descriptions: BookingTextConstants.deletingRoom,
                            title: BookingTextConstants.deleting,
                            onYes: () async {
                              tokenExpireWrapper(ref, () async {
                                final value =
                                    await roomListNotifier.deleteRoom(r);
                                if (value) {
                                  displayBookingToast(context, TypeMsg.msg,
                                      BookingTextConstants.deletedRoom);
                                } else {
                                  displayBookingToast(context, TypeMsg.error,
                                      BookingTextConstants.deletingError);
                                }
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
        ));
  }
}
