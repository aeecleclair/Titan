import 'package:myecl/booking/providers/booking_page_provider.dart';

String getPageTitle(BookingPage i) {
  switch (i) {
    case BookingPage.main:
      return 'Réservation';
    case BookingPage.addBooking:
      return 'Demande';
    case BookingPage.history:
      return 'Historique';
    case BookingPage.admin:
      return 'Administrateur';
    default:
      return 'Booking';
  }
}

String processDate(DateTime date) {
  return date.toIso8601String().split('T')[0];
}
