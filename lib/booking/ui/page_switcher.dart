import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/ui/pages/add_booking_page/add_booking_page.dart';
import 'package:myecl/booking/ui/pages/add_room_page/add_room_page.dart';
import 'package:myecl/booking/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/booking/ui/pages/bookings_page/bookings_page.dart';
import 'package:myecl/booking/ui/pages/edit_booking_page/edit_booking_page.dart';
import 'package:myecl/booking/ui/pages/edit_room_page/edit_room_page.dart';
import 'package:myecl/booking/ui/pages/main_page/main_page.dart';
import 'package:myecl/booking/ui/pages/rooms_page/rooms_pages.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(bookingPageProvider);
    switch (page) {
      case BookingPage.main:
        return const MainPage();
      case BookingPage.addBooking:
        return const AddBookingPage();
      case BookingPage.admin:
        return const AdminPage();
      case BookingPage.bookings:
        return const BookingsPage();
      case BookingPage.rooms:
        return const RoomsPage();
      case BookingPage.addRoom:
        return const AddRoomPage();
      case BookingPage.editRoom:
        return const EditRoomPage();
      case BookingPage.editBooking:
        return const EditBookingPage();
    }
  }
}
