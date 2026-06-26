import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class BookingNotifier extends Notifier<BookingReturnApplicant> {
  @override
  BookingReturnApplicant build() {
    return BookingReturnApplicant.empty();
  }

  void setBooking(BookingReturnApplicant booking) {
    state = booking;
  }
}

final bookingProvider =
    NotifierProvider<BookingNotifier, BookingReturnApplicant>(
      BookingNotifier.new,
    );
