import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/booking/providers/manager_booking_list_provider.dart';
import 'package:titan/booking/repositories/booking_repository.dart';
import 'package:titan/tools/functions.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  group('BookingListProvider', () {
    test('Should load manager bookings', () async {
      final mockBookingRepository = MockBookingRepository();
      when(
        () => mockBookingRepository.getUserManageBookingList(),
      ).thenAnswer((_) async => [Booking.empty(), Booking.empty()]);
      final managerBookingListProvider = ManagerBookingListProvider(
        bookingRepository: mockBookingRepository,
      );
      final bookings = await managerBookingListProvider
          .loadUserManageBookings();
      expect(bookings, isA<AsyncData<List<Booking>>>());
      expect(
        bookings.maybeWhen(data: (data) => data, orElse: () => []).length,
        2,
      );
    });

    test('Should update a booking', () async {
      final mockBookingRepository = MockBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(
        () => mockBookingRepository.getUserManageBookingList(),
      ).thenAnswer((_) async => [Booking.empty(), newBooking]);
      when(
        () => mockBookingRepository.updateBooking(newBooking),
      ).thenAnswer((_) async => true);
      final bookingListProvider = ManagerBookingListProvider(
        bookingRepository: mockBookingRepository,
      );
      await bookingListProvider.loadUserManageBookings();
      final booking = await bookingListProvider.updateBooking(newBooking);
      expect(booking, true);
    });

    test(
      'toggleConfirmed should return true if booking is confirmed successfully',
      () async {
        final mockBookingRepository = MockBookingRepository();
        final newBooking = Booking.empty().copyWith(id: "1");
        when(
          () => mockBookingRepository.getUserManageBookingList(),
        ).thenAnswer((_) async => [Booking.empty(), newBooking]);
        when(
          () => mockBookingRepository.confirmBooking(
            newBooking,
            Decision.approved,
          ),
        ).thenAnswer((_) async => true);
        final bookingListProvider = ManagerBookingListProvider(
          bookingRepository: mockBookingRepository,
        );
        await bookingListProvider.loadUserManageBookings();
        final result = await bookingListProvider.toggleConfirmed(
          newBooking,
          Decision.approved,
        );
        expect(result, true);
      },
    );
  });
}
