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
      case 0:
        return Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Calendar(),
                const Button(
                  text: "Demande",
                  index: 1,
                ),
                const Button(
                  text: "Historique",
                  index: 2,
                ),
                isAdmin
                    ? const Button(
                        text: "Administration",
                        index: 3,
                      )
                    : Container(),
                const SizedBox()
              ]),
        );
      case 1:
        return const FormPage();
      case 2:
        return const ListBooking(isAdmin: false);
      case 3:
        return const ListBooking(isAdmin: true);
      default:
        return Container();
    }
  }
}
