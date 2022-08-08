import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/ui/pages/add_booking_page/form_page.dart';
import 'package:myecl/booking/ui/booking_list.dart';
import 'package:myecl/booking/ui/pages/main_page/main_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(bookingPageProvider);
    switch (page) {
      case BookingPage.main:
        return const MainPage();
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
