import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/booking/adapters/booking_return.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class UserBookingListProvider extends ListNotifierAPI<BookingReturn> {
  Openapi get bookingRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<BookingReturn>> build() {
    loadUserBookings();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<BookingReturn>>> loadUserBookings() async {
    return await loadList(bookingRepository.bookingBookingsUsersMeGet);
  }

  Future<bool> addBooking(BookingBase booking) async {
    return await add(
      () => bookingRepository.bookingBookingsPost(body: booking),
      booking,
    );
  }

  Future<bool> updateBooking(BookingReturn booking) async {
    return await update(
      () => bookingRepository.bookingBookingsBookingIdPatch(
        bookingId: booking.id,
        body: booking.toBookingEdit(),
      ),
      (booking) => booking.id,
      booking,
    );
  }

  Future<bool> deleteBooking(BookingReturn booking) async {
    return await delete(
      () => bookingRepository.bookingBookingsBookingIdDelete(
        bookingId: booking.id,
      ),
      (booking) => booking.id,
      booking.id,
    );
  }
}

final userBookingListProvider =
    NotifierProvider<UserBookingListProvider, AsyncValue<List<BookingReturn>>>(
      UserBookingListProvider.new,
    );
