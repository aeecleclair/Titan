import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/providers/is_booking_admin_provider.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/ui/button.dart';
import 'package:myecl/booking/ui/calendar.dart';
import 'package:myecl/booking/ui/form_page.dart';
import 'package:myecl/booking/ui/booking_list.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(bookingPageProvider);
    final isAdmin = ref.watch(isBookingAdminProvider);
    switch (page) {
      case BookingPage.main:
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
      case BookingPage.addBooking:
        return const FormPage();
      case BookingPage.history:
        return const ListBooking(isAdmin: false);
      case BookingPage.admin:
        return const ListBooking(isAdmin: true);
      default:
        return Container();
    }
  }
}
