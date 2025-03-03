import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class BookingNotifier extends StateNotifier<BookingReturnApplicant> {
  BookingNotifier() : super(EmptyModels.empty<BookingReturnApplicant>());

  void setBooking(BookingReturnApplicant booking) {
    state = booking;
  }
}

final bookingProvider =
    StateNotifierProvider<BookingNotifier, BookingReturnApplicant>((ref) {
  return BookingNotifier();
});
