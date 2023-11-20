import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/user_booking_repository.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockUserBookingRepository extends Mock implements UserBookingRepository {}

void main() {
  group('UserBookingListProvider', () {
    late UserBookingRepository userRepository;
    late UserBookingListProvider provider;

    setUp(() {
      userRepository = MockUserBookingRepository();
      provider = UserBookingListProvider(userRepository: userRepository);
    });

    test('initial state is loading', () {
      expect(provider.state, isA<AsyncLoading>());
    });

    test('setId sets userId', () {
      provider.setId('123');
      expect(provider.userId, '123');
    });

    test('loadUserBookings loads bookings from repository', () async {
      final bookings = [
        Booking.empty().copyWith(id: '1'),
        Booking.empty().copyWith(id: '2')
      ];
      when(() => userRepository.getMyBookingList(provider.userId))
          .thenAnswer((_) async => bookings);

      final result = await provider.loadUserBookings();

      expect(result, AsyncValue.data(bookings));
      verify(() => userRepository.getMyBookingList(provider.userId)).called(1);
    });

    test('addBooking adds booking to state', () async {
      final booking = Booking.empty().copyWith(id: '3');
      final bookings = [
        Booking.empty().copyWith(id: '1'),
        Booking.empty().copyWith(id: '2')
      ];
      when(() => userRepository.getMyBookingList(provider.userId))
          .thenAnswer((_) async => bookings.sublist(0));

      await provider.loadUserBookings();

      final result = await provider.addBooking(booking);

      expect(result, true);
      expect(
          provider.state.when(
            data: (data) => data,
            loading: () => [],
            error: (error, stack) => [],
          ),
          [...bookings, booking]);
    });

    test('updateBooking updates booking in state', () async {
      final booking1 = Booking.empty().copyWith(id: '1');
      final booking2 = Booking.empty().copyWith(id: '2');
      final booking3 = Booking.empty().copyWith(id: '3');
      final newBooking2 = booking2.copyWith(reason: 'new name');
      provider.state = AsyncValue.data([booking1, booking2]);
      final bookings = [booking1, booking2, booking3];
      final updatedBookings = [booking1, newBooking2, booking3];
      when(() => userRepository.getMyBookingList(provider.userId))
          .thenAnswer((_) async => bookings.sublist(0));

      await provider.loadUserBookings();

      final result1 = await provider.updateBooking(newBooking2);

      expect(result1, true);
      expect(
          provider.state.when(
            data: (data) => data,
            loading: () => [],
            error: (error, stack) => [],
          ),
          updatedBookings);
    });

    test('deleteBooking deletes booking from state', () async {
      final booking1 = Booking.empty().copyWith(id: '1');
      final booking2 = Booking.empty().copyWith(id: '2');
      provider.state = AsyncValue.data([booking1, booking2]);
      final bookings = [booking1, booking2];
      when(() => userRepository.getMyBookingList(provider.userId))
          .thenAnswer((_) async => bookings.sublist(0));

      await provider.loadUserBookings();

      final result1 = await provider.deleteBooking(booking2);
      final result2 =
          await provider.deleteBooking(Booking.empty().copyWith(id: '3'));

      expect(result1, true);
      expect(result2, false);
      expect(
          provider.state.when(
            data: (data) => data,
            loading: () => [],
            error: (error, stack) => [],
          ),
          [booking1]);
    });
  });
}
