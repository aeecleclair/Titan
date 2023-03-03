import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking_card.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ListBooking extends HookConsumerWidget {
  final List<Booking> bookings;
  final bool canToggle;
  final String title;
  const ListBooking({
    Key? key,
    required this.bookings,
    required this.title,
    this.canToggle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    final bookingNotifier = ref.watch(bookingProvider.notifier);
    final bookingListNotifier = ref.watch(bookingListProvider.notifier);
    final confirmedBookingListNotifier =
        ref.watch(confirmedBookingListProvider.notifier);
    final outerController = useScrollController();
    final innerController = useScrollController();
    final toggle = useState(!canToggle);
    if (bookings.isNotEmpty) {
      return Column(children: [
        GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (canToggle) {
                toggle.value = !toggle.value;
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "$title${bookings.length > 1 ? "s" : ""} (${bookings.length})",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 149, 149, 149))),
                  ),
                  if (canToggle)
                    HeroIcon(
                      toggle.value
                          ? HeroIcons.chevronUp
                          : HeroIcons.chevronDown,
                      color: const Color.fromARGB(255, 149, 149, 149),
                      size: 30,
                    ),
                ],
              ),
            )),
        if (toggle.value)
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 220,
            child: ListView(
              controller: outerController,
              clipBehavior: Clip.none,
              children: [
                Listener(
                  onPointerSignal: (event) {
                    if (event is PointerScrollEvent) {
                      final offset = event.scrollDelta.dy;
                      innerController.jumpTo(innerController.offset + offset);
                      outerController.jumpTo(outerController.offset - offset);
                    }
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: innerController,
                    clipBehavior: Clip.none,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        ...bookings.map((e) => BookingCard(
                              booking: e,
                              isAdmin: true,
                              isDetail: false,
                              onEdit: () {
                                bookingNotifier.setBooking(e);
                                pageNotifier.setBookingPage(
                                    BookingPage.addEditBookingFromAdmin);
                              },
                              onInfo: () {
                                bookingNotifier.setBooking(e);
                                pageNotifier.setBookingPage(
                                    BookingPage.detailBookingFromAdmin);
                              },
                              onConfirm: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialogBox(
                                          title: BookingTextConstants.confirm,
                                          descriptions: BookingTextConstants
                                              .confirmBooking,
                                          onYes: () async {
                                            await tokenExpireWrapper(ref,
                                                () async {
                                              Booking newBooking = e.copyWith(
                                                  decision: Decision.approved);
                                              bookingListNotifier
                                                  .toggleConfirmed(newBooking,
                                                      Decision.approved)
                                                  .then((value) {
                                                if (value) {
                                                  confirmedBookingListNotifier
                                                      .addBooking(newBooking);
                                                }
                                              });
                                            });
                                          });
                                    });
                              },
                              onDecline: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialogBox(
                                          title: BookingTextConstants.decline,
                                          descriptions: BookingTextConstants
                                              .declineBooking,
                                          onYes: () async {
                                            await tokenExpireWrapper(ref,
                                                () async {
                                              Booking newBooking = e.copyWith(
                                                  decision: Decision.declined);
                                              bookingListNotifier
                                                  .toggleConfirmed(newBooking,
                                                      Decision.declined)
                                                  .then((value) {
                                                if (value) {
                                                  confirmedBookingListNotifier
                                                      .deleteBooking(
                                                          newBooking);
                                                }
                                              });
                                            });
                                          });
                                    });
                              },
                              onCopy: () {
                                bookingNotifier.setBooking(e.copyWith(id: ""));
                                pageNotifier.setBookingPage(
                                    BookingPage.addEditBookingFromAdmin);
                              },
                              onDelete: () async {},
                            )),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          )
      ]);
    } else {
      return const SizedBox();
    }
  }
}
