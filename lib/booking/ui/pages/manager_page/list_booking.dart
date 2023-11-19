import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/manager_booking_list_provider.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/providers/manager_confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/components/booking_card.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:qlevar_router/qlevar_router.dart';

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
    final bookingNotifier = ref.watch(bookingProvider.notifier);
    final bookingListNotifier = ref.watch(managerBookingListProvider.notifier);
    final confirmedBookingListNotifier =
        ref.watch(confirmedBookingListProvider.notifier);
    final managerConfirmedBookingListNotifier =
        ref.watch(managerConfirmedBookingListProvider.notifier);

    final toggle = useState(!canToggle);
    if (bookings.isNotEmpty) {
      return Column(
        children: [
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
              child: HorizontalListView.builder(
                  height: 210,
                  horizontalSpace: 10,
                  items: bookings,
                  itemBuilder: (context, e, i) => BookingCard(
                        booking: e,
                        isAdmin: true,
                        isDetail: false,
                        onEdit: () {
                          bookingNotifier.setBooking(e);
                          QR.to(BookingRouter.root +
                              BookingRouter.manager +
                              BookingRouter.addEdit);
                        },
                        onInfo: () {
                          bookingNotifier.setBooking(e);
                          QR.to(BookingRouter.root +
                              BookingRouter.manager +
                              BookingRouter.detail);
                        },
                        onConfirm: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialogBox(
                                    title: BookingTextConstants.confirm,
                                    descriptions:
                                        BookingTextConstants.confirmBooking,
                                    onYes: () async {
                                      await tokenExpireWrapper(ref, () async {
                                        Booking newBooking = e.copyWith(
                                            decision: Decision.approved);
                                        bookingListNotifier
                                            .toggleConfirmed(
                                                newBooking, Decision.approved)
                                            .then((value) {
                                          if (value) {
                                            ref
                                                .watch(userBookingListProvider
                                                    .notifier)
                                                .loadUserBookings();
                                            confirmedBookingListNotifier
                                                .addBooking(newBooking);
                                            managerConfirmedBookingListNotifier
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
                                    descriptions:
                                        BookingTextConstants.declineBooking,
                                    onYes: () async {
                                      await tokenExpireWrapper(ref, () async {
                                        Booking newBooking = e.copyWith(
                                            decision: Decision.declined);
                                        bookingListNotifier
                                            .toggleConfirmed(
                                                newBooking, Decision.declined)
                                            .then((value) {
                                          if (value) {
                                            ref
                                                .watch(userBookingListProvider
                                                    .notifier)
                                                .loadUserBookings();
                                            confirmedBookingListNotifier
                                                .deleteBooking(newBooking);
                                            managerConfirmedBookingListNotifier
                                                .deleteBooking(newBooking);
                                          }
                                        });
                                      });
                                    });
                              });
                        },
                        onCopy: () {
                          bookingNotifier.setBooking(e.copyWith(id: ""));
                          QR.to(BookingRouter.root +
                              BookingRouter.manager +
                              BookingRouter.addEdit);
                        },
                        onDelete: () async {},
                      )),
            ),
          const SizedBox(height: 30),
        ],
      );
    }
    return const SizedBox();
  }
}
