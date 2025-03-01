import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserBookingListProvider extends ListNotifier2<BookingReturn> {
  final Openapi bookingRepository;
  UserBookingListProvider({required this.bookingRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<BookingReturn>>> loadUserBookings() async {
    return await loadList(bookingRepository.bookingBookingsUsersMeGet);
  }

  Future<bool> addBooking(BookingBase booking) async {
    return await add(() => bookingRepository.bookingBookingsPost(body: booking), booking);
  }

  Future<bool> updateBooking(BookingReturn booking) async {
    return await update(
      () => bookingRepository.bookingBookingsBookingIdPatch(bookingId: booking.id, body: BookingEdit(
        reason: booking.reason,
        start: booking.start,
        end: booking.end,
        note: booking.note,
        roomId: booking.roomId,
        key: booking.key,
        recurrenceRule: booking.recurrenceRule,
        entity: booking.entity,
      )),
      (bookings, booking) =>
          bookings..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
      booking,
    );
  }

  Future<bool> deleteBooking(BookingReturn booking) async {
    return await delete(
      () => bookingRepository.bookingBookingsBookingIdDelete(bookingId: booking.id),
      (bookings, booking) => bookings..removeWhere((i) => i.id == booking.id),
      booking,
    );
  }
}

final userBookingListProvider =
    StateNotifierProvider<UserBookingListProvider, AsyncValue<List<BookingReturn>>>(
        (ref) {
  final bookingRepository = ref.watch(repositoryProvider);
  final provider =
      UserBookingListProvider(bookingRepository: bookingRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadUserBookings();
  });
  return provider;
});
