import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/booking/repositories/booking_repository.dart';
import 'package:titan/booking/providers/user_booking_list_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  group('UserBookingListProvider', () {
    late BookingRepository bookingRepository;
    late UserBookingListProvider provider;

    setUp(() {
      bookingRepository = MockBookingRepository();
      provider = UserBookingListProvider(bookingRepository: bookingRepository);
    });

    test('initial state is loading', () {
      expect(provider.state, isA<AsyncLoading>());
    });

    test('loadUserBookings loads bookings from repository', () async {
      final bookings = [
        Booking.empty().copyWith(id: '1'),
        Booking.empty().copyWith(id: '2'),
      ];
      when(
        () => bookingRepository.getUserBookingList(),
      ).thenAnswer((_) async => bookings);

      final result = await provider.loadUserBookings();

      expect(result, AsyncValue.data(bookings));
      verify(() => bookingRepository.getUserBookingList()).called(1);
    });

    test('Should add a booking', () async {
      final mockBookingRepository = MockBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(
        () => mockBookingRepository.getUserBookingList(),
      ).thenAnswer((_) async => [Booking.empty(), Booking.empty()]);
      when(
        () => mockBookingRepository.createBooking(newBooking),
      ).thenAnswer((_) async => newBooking);
      final bookingListProvider = UserBookingListProvider(
        bookingRepository: mockBookingRepository,
      );
      await bookingListProvider.loadUserBookings();
      final booking = await bookingListProvider.addBooking(newBooking);
      expect(booking, true);
    });

    test('Should update a booking', () async {
      final mockBookingRepository = MockBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(
        () => mockBookingRepository.getUserBookingList(),
      ).thenAnswer((_) async => [Booking.empty(), newBooking]);
      when(
        () => mockBookingRepository.updateBooking(newBooking),
      ).thenAnswer((_) async => true);
      final bookingListProvider = UserBookingListProvider(
        bookingRepository: mockBookingRepository,
      );
      await bookingListProvider.loadUserBookings();
      final booking = await bookingListProvider.updateBooking(newBooking);
      expect(booking, true);
    });

    test('Should delete a booking', () async {
      final mockBookingRepository = MockBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(
        () => mockBookingRepository.getUserBookingList(),
      ).thenAnswer((_) async => [Booking.empty(), newBooking]);
      when(
        () => mockBookingRepository.deleteBooking(newBooking.id),
      ).thenAnswer((_) async => true);
      final bookingListProvider = UserBookingListProvider(
        bookingRepository: mockBookingRepository,
      );
      await bookingListProvider.loadUserBookings();
      final booking = await bookingListProvider.deleteBooking(newBooking);
      expect(booking, true);
    });
  });
}
