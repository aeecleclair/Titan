import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/tools/dialog.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/booking/ui/booking_button.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class BookingUi extends ConsumerWidget {
  final Booking booking;
  final bool isAdmin;
  const BookingUi({Key? key, required this.booking, required this.isAdmin})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    final bookingNotifier = ref.watch(bookingProvider.notifier);
    final bookingListNotifier = ref.watch(bookingListProvider.notifier);
    void displayBookingToastWithContext(TypeMsg type, String msg) {
      displayBookingToast(context, type, msg);
    }

    return SizedBox(
        height: 115,
        width: MediaQuery.of(context).size.width,
        child: Container(
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: BookingColorConstants.softBlack,
                  offset: const Offset(2, 3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Text(
                        "${booking.room.name} - ${booking.reason}",
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: BookingColorConstants.darkBlue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${processDateWithHour(booking.start)} - ${processDateWithHour(booking.end)}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: BookingColorConstants.lightBlue,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      booking.note,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: BookingColorConstants.darkBlue,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                  ],
                ),
              ),
              isAdmin
                  ? SizedBox(
                      width: 115,
                      child: Row(
                        children: [
                          BookingButton(
                              res: booking,
                              color: BookingColorConstants.darkBlue,
                              state: Decision.approved),
                          const SizedBox(
                            width: 5,
                          ),
                          BookingButton(
                              res: booking,
                              color: BookingColorConstants.veryLightBlue,
                              state: Decision.declined)
                        ],
                      ),
                    )
                  : SizedBox(
                      width: 130,
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 118, 187, 202),
                                      Color.fromARGB(255, 87, 143, 186)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 87, 143, 186)
                                          .withOpacity(0.4),
                                      offset: const Offset(2, 3),
                                      blurRadius: 5)
                                ],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const HeroIcon(
                                HeroIcons.pencilSquare,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              bookingNotifier.setBooking(booking);
                              pageNotifier
                                  .setBookingPage(BookingPage.editBooking);
                            },
                          ),
                          Container(
                            width: 20,
                          ),
                          GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        BookingColorConstants.darkBlue,
                                        BookingColorConstants.lightBlue
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: const HeroIcon(
                                  HeroIcons.trash,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        BookingDialog(
                                            descriptions: BookingTextConstants
                                                .deletingBooking,
                                            title:
                                                BookingTextConstants.deleting,
                                            onYes: () async {
                                              tokenExpireWrapper(ref, () async {
                                                final value =
                                                    await bookingListNotifier
                                                        .deleteBooking(booking);
                                                if (value) {
                                                  displayBookingToastWithContext(
                                                      TypeMsg.msg,
                                                      BookingTextConstants
                                                          .deletedBooking);
                                                } else {
                                                  displayBookingToastWithContext(
                                                      TypeMsg.error,
                                                      BookingTextConstants
                                                          .deletingError);
                                                }
                                              });
                                            }));
                              })
                        ],
                      ),
                    ),
            ])));
  }
}
