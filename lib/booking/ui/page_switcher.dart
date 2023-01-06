import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/ui/pages/detail_pages/detail_booking.dart';
import 'package:myecl/booking/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/booking/ui/pages/booking_pages/add_edit_booking_page.dart';
import 'package:myecl/booking/ui/pages/room_pages/add_edit_room_page.dart';
import 'package:myecl/booking/ui/pages/main_page/main_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(bookingPageProvider);
    switch (page) {
      case BookingPage.main:
        return const MainPage();
      case BookingPage.addEditBooking:
        return const AddEditBookingPage();
      case BookingPage.admin:
        return const AdminPage();
      case BookingPage.addEditRoom:
        return const AddEditRoomPage();
      case BookingPage.detailBookingFromAdmin:
        return const DetailBookingPage();
      case BookingPage.detailBookingFromMain:
        return const DetailBookingPage();
      case BookingPage.addEditBookingFromAdmin:
        return const AddEditBookingPage();
    }
  }
}
