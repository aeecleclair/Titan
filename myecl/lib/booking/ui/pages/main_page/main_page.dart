import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/providers/is_booking_admin_provider.dart';
import 'package:myecl/booking/ui/button.dart';
import 'package:myecl/booking/ui/pages/main_page/calendar.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isBookingAdminProvider);
    return Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Calendar(),
                const Button(
                  text: "Demande",
                  page: BookingPage.addBooking,
                ),
                const Button(
                  text: "Historique",
                  page: BookingPage.history,
                ),
                isAdmin
                    ? const Button(
                        text: "Administration",
                        page: BookingPage.admin,
                      )
                    : Container(),
                const SizedBox()
              ]),
        );
  }
}