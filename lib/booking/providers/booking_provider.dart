import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class BookingNotifier extends StateNotifier<BookingReturnApplicant> {
  BookingNotifier() : super(BookingReturnApplicant.fromJson({}));

  void setBooking(BookingReturnApplicant booking) {
    state = booking;
  }
}

final bookingProvider = StateNotifierProvider<BookingNotifier, BookingReturnApplicant>((ref) {
  return BookingNotifier();
});
