import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/booking/adapters/booking.dart';

class UserBookingListProvider extends ListNotifierAPI<BookingReturn> {
  final Openapi bookingRepository;
  UserBookingListProvider({required this.bookingRepository})
      : super(const AsyncValue.loading());

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

  Future<bool> deleteBooking(String bookingId) async {
    return await delete(
      () => bookingRepository.bookingBookingsBookingIdDelete(
        bookingId: bookingId,
      ),
      (b) => b.id,
      bookingId,
    );
  }
}

final userBookingListProvider = StateNotifierProvider<UserBookingListProvider,
    AsyncValue<List<BookingReturn>>>((ref) {
  final bookingRepository = ref.watch(repositoryProvider);
  final provider =
      UserBookingListProvider(bookingRepository: bookingRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadUserBookings();
  });
  return provider;
});
