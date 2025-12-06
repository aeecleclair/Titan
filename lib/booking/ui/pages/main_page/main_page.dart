import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/booking/providers/booking_provider.dart';
import 'package:titan/booking/providers/confirmed_booking_list_provider.dart';
import 'package:titan/booking/providers/is_admin_provider.dart';
import 'package:titan/booking/providers/manager_booking_list_provider.dart';
import 'package:titan/booking/providers/selected_days_provider.dart';
import 'package:titan/booking/providers/user_booking_list_provider.dart';
import 'package:titan/booking/router.dart';
import 'package:titan/booking/tools/constants.dart';
import 'package:titan/booking/ui/booking.dart';
import 'package:titan/booking/ui/calendar/calendar.dart';
import 'package:titan/booking/ui/components/booking_card.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookingMainPage extends HookConsumerWidget {
  const BookingMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double minCalendarHeight = 400;
    const double sumOfHeightOfOthersWidgets = 361;
    final isManager = ref.watch(isManagerProvider);
    final isAdmin = ref.watch(isBookingAdminProvider);
    final bookingsNotifier = ref.watch(userBookingListProvider.notifier);
    final confirmedBookingsNotifier = ref.watch(
      confirmedBookingListProvider.notifier,
    );
    final bookings = ref.watch(userBookingListProvider);
    final bookingNotifier = ref.watch(bookingProvider.notifier);
    final selectedDaysNotifier = ref.watch(selectedDaysProvider.notifier);

    void displayToastWithContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    void handleBooking(Booking booking) {
      bookingNotifier.setBooking(booking);
      final recurrentDays = SfCalendar.parseRRule(
        booking.recurrenceRule,
        booking.start,
      ).weekDays;
      selectedDaysNotifier.setSelectedDays(recurrentDays);
      QR.to(BookingRouter.root + BookingRouter.addEdit);
    }

    return BookingTemplate(
      child: LayoutBuilder(
        builder: (context, constraints) => Refresher(
          onRefresh: () async {
            await confirmedBookingsNotifier.loadConfirmedBooking();
            await bookingsNotifier.loadUserBookings();
          },
          child: SizedBox(
            height: max(
              constraints.maxHeight,
              minCalendarHeight + sumOfHeightOfOthersWidgets,
            ),
            child: Column(
              children: [
                if (isAdmin | isManager) const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (isManager)
                        AdminButton(
                          text: BookingTextConstants.management,
                          onTap: () {
                            QR.to(BookingRouter.root + BookingRouter.manager);
                          },
                        ),
                      if (isAdmin)
                        AdminButton(
                          onTap: () {
                            QR.to(BookingRouter.root + BookingRouter.admin);
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Expanded(child: Calendar(isManagerPage: false)),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      BookingTextConstants.myBookings,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 149, 149),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AsyncChild(
                  value: bookings,
                  builder: (context, data) {
                    data.sort((a, b) => b.creation.compareTo(a.creation));
                    return HorizontalListView.builder(
                      height: 210,
                      firstChild: GestureDetector(
                        onTap: () {
                          bookingNotifier.setBooking(Booking.empty());
                          selectedDaysNotifier.clear();
                          QR.to(BookingRouter.root + BookingRouter.addEdit);
                        },
                        child: const CardLayout(
                          width: 120,
                          height: 200,
                          child: Center(
                            child: HeroIcon(
                              HeroIcons.plus,
                              size: 40.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      items: data,
                      itemBuilder: (context, e, i) => BookingCard(
                        booking: e,
                        onEdit: () {
                          handleBooking(e);
                        },
                        onInfo: () {
                          bookingNotifier.setBooking(e);
                          QR.to(BookingRouter.root + BookingRouter.detail);
                        },
                        onDelete: () async {
                          await tokenExpireWrapper(ref, () async {
                            await showDialog(
                              context: context,
                              builder: (context) => CustomDialogBox(
                                descriptions: BookingTextConstants
                                    .deleteBookingConfirmation,
                                onYes: () async {
                                  final value = await bookingsNotifier
                                      .deleteBooking(e);
                                  if (value) {
                                    ref
                                        .read(
                                          managerBookingListProvider.notifier,
                                        )
                                        .loadUserManageBookings;
                                    displayToastWithContext(
                                      TypeMsg.msg,
                                      BookingTextConstants.deleteBooking,
                                    );
                                  } else {
                                    displayToastWithContext(
                                      TypeMsg.error,
                                      BookingTextConstants.deletingError,
                                    );
                                  }
                                },
                                title: BookingTextConstants.deleteBooking,
                              ),
                            );
                          });
                        },
                        onCopy: () {
                          handleBooking(e.copyWith(id: ""));
                        },
                      ),
                    );
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
