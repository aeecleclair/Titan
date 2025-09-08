import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/booking/providers/confirmed_booking_list_provider.dart';
import 'package:titan/booking/providers/manager_booking_list_provider.dart';
import 'package:titan/booking/providers/booking_provider.dart';
import 'package:titan/booking/providers/manager_confirmed_booking_list_provider.dart';
import 'package:titan/booking/providers/user_booking_list_provider.dart';
import 'package:titan/booking/providers/selected_days_provider.dart';
import 'package:titan/booking/router.dart';
import 'package:titan/booking/tools/constants.dart';
import 'package:titan/booking/ui/components/booking_card.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ListBooking extends HookConsumerWidget {
  final List<Booking> bookings;
  final bool canToggle;
  final String title;
  const ListBooking({
    super.key,
    required this.bookings,
    required this.title,
    this.canToggle = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingNotifier = ref.watch(bookingProvider.notifier);
    final bookingListNotifier = ref.watch(managerBookingListProvider.notifier);
    final confirmedBookingListNotifier = ref.watch(
      confirmedBookingListProvider.notifier,
    );
    final managerConfirmedBookingListNotifier = ref.watch(
      managerConfirmedBookingListProvider.notifier,
    );
    final selectedDaysNotifier = ref.watch(selectedDaysProvider.notifier);

    final toggle = useState(!canToggle);

    void handleBooking(Booking booking) {
      bookingNotifier.setBooking(booking);
      final recurrentDays = SfCalendar.parseRRule(
        booking.recurrenceRule,
        booking.start,
      ).weekDays;
      selectedDaysNotifier.setSelectedDays(recurrentDays);
      QR.to(BookingRouter.root + BookingRouter.manager + BookingRouter.addEdit);
    }

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
                        color: Color.fromARGB(255, 149, 149, 149),
                      ),
                    ),
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
            ),
          ),
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
                    handleBooking(e);
                  },
                  onInfo: () {
                    bookingNotifier.setBooking(e);
                    QR.to(
                      BookingRouter.root +
                          BookingRouter.manager +
                          BookingRouter.detail,
                    );
                  },
                  onConfirm: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialogBox(
                          title: BookingTextConstants.confirm,
                          descriptions: BookingTextConstants.confirmBooking,
                          onYes: () async {
                            await tokenExpireWrapper(ref, () async {
                              Booking newBooking = e.copyWith(
                                decision: Decision.approved,
                              );
                              bookingListNotifier
                                  .toggleConfirmed(
                                    newBooking,
                                    Decision.approved,
                                  )
                                  .then((value) {
                                    if (value) {
                                      ref
                                          .read(
                                            userBookingListProvider.notifier,
                                          )
                                          .loadUserBookings();
                                      confirmedBookingListNotifier.addBooking(
                                        newBooking,
                                      );
                                      managerConfirmedBookingListNotifier
                                          .addBooking(newBooking);
                                    }
                                  });
                            });
                          },
                        );
                      },
                    );
                  },
                  onDecline: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialogBox(
                          title: BookingTextConstants.decline,
                          descriptions: BookingTextConstants.declineBooking,
                          onYes: () async {
                            await tokenExpireWrapper(ref, () async {
                              Booking newBooking = e.copyWith(
                                decision: Decision.declined,
                              );
                              bookingListNotifier
                                  .toggleConfirmed(
                                    newBooking,
                                    Decision.declined,
                                  )
                                  .then((value) {
                                    if (value) {
                                      ref
                                          .read(
                                            userBookingListProvider.notifier,
                                          )
                                          .loadUserBookings();
                                      confirmedBookingListNotifier
                                          .deleteBooking(newBooking);
                                      managerConfirmedBookingListNotifier
                                          .deleteBooking(newBooking);
                                    }
                                  });
                            });
                          },
                        );
                      },
                    );
                  },
                  onCopy: () {
                    bookingNotifier.setBooking(e.copyWith(id: ""));
                    QR.to(
                      BookingRouter.root +
                          BookingRouter.manager +
                          BookingRouter.addEdit,
                    );
                  },
                  onDelete: () async {},
                ),
              ),
            ),
          const SizedBox(height: 30),
        ],
      );
    }
    return const SizedBox();
  }
}
