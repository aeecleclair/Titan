import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';
import 'package:myecl/booking/repositories/user_booking_repository.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

class MockUserBookingRepository extends Mock implements UserBookingRepository {}

void main() {
  group('BookingListProvider', () {
    test('Should load bookings', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [
                Booking.empty(),
                Booking.empty(),
              ]);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      final bookings = await bookingListProvider.loadBookings();
      expect(bookings, isA<AsyncData<List<Booking>>>());
      expect(
          bookings
              .when(
                data: (data) => data,
                loading: () => [],
                error: (error, stack) => [],
              )
              .length,
          2);
    });

    test('Should load user bookings', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      when(() => mockUserBookingRepository.getMyBookingList("1"))
          .thenAnswer((_) async => [
                Booking.empty(),
                Booking.empty(),
              ]);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      final bookings = await bookingListProvider.loadUserBookings("1");
      expect(bookings, isA<AsyncData<List<Booking>>>());
      expect(
          bookings
              .when(
                data: (data) => data,
                loading: () => [],
                error: (error, stack) => [],
              )
              .length,
          2);
    });

    test('Should add a booking', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [
                Booking.empty(),
                Booking.empty(),
              ]);
      when(() => mockBookingRepository.createBooking(newBooking))
          .thenAnswer((_) async => newBooking);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      await bookingListProvider.loadBookings();
      final booking = await bookingListProvider.addBooking(newBooking);
      expect(booking, true);
    });

    test('Should update a booking', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [Booking.empty(), newBooking]);
      when(() => mockBookingRepository.updateBooking(newBooking))
          .thenAnswer((_) async => true);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      await bookingListProvider.loadBookings();
      final booking = await bookingListProvider.updateBooking(newBooking);
      expect(booking, true);
    });

    test('Should delete a booking', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [Booking.empty(), newBooking]);
      when(() => mockBookingRepository.deleteBooking(newBooking.id))
          .thenAnswer((_) async => true);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      await bookingListProvider.loadBookings();
      final booking = await bookingListProvider.deleteBooking(newBooking);
      expect(booking, true);
    });

    test(
        'toggleConfirmed should return true if booking is confirmed successfully',
        () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [Booking.empty(), newBooking]);
      when(() => mockBookingRepository.confirmBooking(
          newBooking, Decision.approved)).thenAnswer((_) async => true);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      await bookingListProvider.loadBookings();
      final result = await bookingListProvider.toggleConfirmed(
          newBooking, Decision.approved);
      expect(result, true);
    });
  });
}
