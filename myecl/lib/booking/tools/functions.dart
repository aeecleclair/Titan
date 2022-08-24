import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/tools/constants.dart';

String getPageTitle(BookingPage i) {
  switch (i) {
    case BookingPage.main:
      return BookingTextConstants.booking;
    case BookingPage.addBooking:
      return BookingTextConstants.addBookingPage;
    case BookingPage.bookings:
      return "Réservations";
    case BookingPage.admin:
      return BookingTextConstants.adminPage;
    default:
      return BookingTextConstants.bookingPage;
  }
}

Decision stringToDecision(String s) {
  switch (s) {
    case "approved":
      return Decision.approved;
    case "declined":
      return Decision.declined;
    case "pending":
      return Decision.pending;
    default:
      return Decision.pending;
  }
}