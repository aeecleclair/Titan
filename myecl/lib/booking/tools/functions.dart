import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/tools/constants.dart';

String getPageTitle(BookingPage i) {
  switch (i) {
    case BookingPage.main:
      return BookingTextConstants.booking;
    case BookingPage.addBooking:
      return BookingTextConstants.addBookingPage;
    case BookingPage.history:
      return BookingTextConstants.historyPage;
    case BookingPage.admin:
      return BookingTextConstants.adminPage;
    default:
      return BookingTextConstants.bookingPage;
  }
}

String processDate(DateTime date) {
  return date.toIso8601String().split('T')[0];
}
