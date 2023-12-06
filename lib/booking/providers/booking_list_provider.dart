import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_provider.dart';

class BookingListProvider extends ListNotifier2<BookingReturn> {
  final Openapi bookingRepository;
  BookingListProvider({required this.bookingRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<BookingReturn>>> loadUserBookings(
      String userId) async {
    return await loadList(() async => bookingRepository
        .bookingBookingsUsersApplicantIdGet(applicantId: userId));
  }

  Future<bool> addBooking(BookingReturn booking) async {
    return await add(
        (booking) async => bookingRepository.bookingBookingsPost(
                body: BookingBase(
              reason: booking.reason,
              start: booking.start,
              end: booking.end,
              note: booking.note,
              roomId: booking.roomId,
              key: booking.key,
              recurrenceRule: booking.recurrenceRule,
              entity: booking.entity,
            )),
        booking);
  }

  Future<bool> updateBooking(BookingReturn booking) async {
    return await update(
        (booking) async => bookingRepository.bookingBookingsBookingIdPatch(
            bookingId: booking.id,
            body: BookingEdit(
              reason: booking.reason,
              start: booking.start,
              end: booking.end,
              note: booking.note,
              key: booking.key,
              recurrenceRule: booking.recurrenceRule,
              entity: booking.entity,
            )),
        (bookings, booking) => bookings
          ..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
        booking);
  }

  Future<bool> deleteBooking(BookingReturn booking) async {
    return await delete(
        (bookingId) async => bookingRepository.bookingBookingsBookingIdDelete(
            bookingId: bookingId),
        (bookings, booking) => bookings..removeWhere((i) => i.id == booking.id),
        booking.id,
        booking);
  }

  Future<bool> toggleConfirmed(
      BookingReturn booking, AppUtilsTypesBookingTypeDecision decision) async {
    return await update(
        (booking) =>
            bookingRepository.bookingBookingsBookingIdReplyDecisionPatch(
                bookingId: booking.id, decision: decision),
        (bookings, booking) => bookings
          ..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
        booking);
  }
}

final bookingListProvider =
    StateNotifierProvider<BookingListProvider, AsyncValue<List<BookingReturn>>>(
        (ref) {
  final bookingRepository = ref.watch(repositoryProvider);
  final provider = BookingListProvider(bookingRepository: bookingRepository);
  tokenExpireWrapperAuth(ref, () async {
    final userId = ref.watch(userProvider);
    await provider.loadUserBookings(userId.id);
  });
  return provider;
});
