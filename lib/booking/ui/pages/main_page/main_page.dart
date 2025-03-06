import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/adapters/booking.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/is_admin_provider.dart';
import 'package:myecl/booking/providers/is_manager_provider.dart';
import 'package:myecl/booking/providers/manager_booking_list_provider.dart';
import 'package:myecl/booking/providers/selected_days_provider.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/booking/ui/calendar/calendar.dart';
import 'package:myecl/booking/ui/components/booking_card.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookingMainPage extends HookConsumerWidget {
  const BookingMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double minCalendarHeight = 400;
    const double sumOfHeightOfOthersWidgets = 361;
    final isManager = ref.watch(isManagerProvider);
    final isAdmin = ref.watch(isAdminProvider);
    final bookingsNotifier = ref.watch(userBookingListProvider.notifier);
    final confirmedBookingsNotifier =
        ref.watch(confirmedBookingListProvider.notifier);
    final bookings = ref.watch(userBookingListProvider);
    final bookingNotifier = ref.watch(bookingProvider.notifier);
    final selectedDaysNotifier = ref.watch(selectedDaysProvider.notifier);

    void displayToastWithContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    void handleBooking(BookingReturnApplicant booking) {
      bookingNotifier.setBooking(booking);
      final recurrentDays =
          SfCalendar.parseRRule(booking.recurrenceRule, booking.start).weekDays;
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
                          onTap: () {
                            QR.to(BookingRouter.root + BookingRouter.manager);
                          },
                        ),
                      if (isAdmin)
                        AdminButton(
                          text: "Gestion",
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
                const SizedBox(
                  height: 10,
                ),
                AsyncChild(
                  value: bookings,
                  builder: (context, data) {
                    data.sort((a, b) => b.creation.compareTo(a.creation));
                    return HorizontalListView.builder(
                      height: 210,
                      firstChild: GestureDetector(
                        onTap: () {
                          bookingNotifier.setBooking(
                            EmptyModels.empty<BookingReturnApplicant>(),
                          );
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
                          handleBooking(e.toBookingReturnApplicant());
                        },
                        onInfo: () {
                          bookingNotifier
                              .setBooking(e.toBookingReturnApplicant());
                          QR.to(BookingRouter.root + BookingRouter.detail);
                        },
                        onDelete: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => CustomDialogBox(
                              descriptions: BookingTextConstants
                                  .deleteBookingConfirmation,
                              onYes: () async {
                                final value =
                                    await bookingsNotifier.deleteBooking(e.id);
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
                        },
                        onCopy: () {
                          handleBooking(
                            e.toBookingReturnApplicant().copyWith(id: ""),
                          );
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
