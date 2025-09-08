import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/booking/providers/confirmed_booking_list_provider.dart';
import 'package:titan/booking/repositories/booking_repository.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  group('ConfirmedBookingListProvider', () {
    test('loadConfirmedBooking returns expected data', () async {
      final mockRepository = MockBookingRepository();
      final bookings = [
        Booking.empty().copyWith(id: '1'),
        Booking.empty().copyWith(id: '2'),
      ];
      when(
        () => mockRepository.getConfirmedBookingList(),
      ).thenAnswer((_) async => bookings);

      final provider = ConfirmedBookingListProvider(
        bookingRepository: mockRepository,
      );
      final result = await provider.loadConfirmedBooking();

      expect(
        result.maybeWhen(data: (data) => data, orElse: () => []),
        bookings,
      );
    });

    test('addBooking adds a booking to the list', () async {
      final mockRepository = MockBookingRepository();
      final bookings = [
        Booking.empty().copyWith(id: '1'),
        Booking.empty().copyWith(id: '2'),
      ];
      final newBooking = Booking.empty().copyWith(id: '3');
      when(
        () => mockRepository.getConfirmedBookingList(),
      ).thenAnswer((_) async => bookings.sublist(0));

      final provider = ConfirmedBookingListProvider(
        bookingRepository: mockRepository,
      );
      await provider.loadConfirmedBooking();
      final result = await provider.addBooking(newBooking);

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        ...bookings,
        newBooking,
      ]);
    });

    test('deleteBooking removes a booking from the list', () async {
      final mockRepository = MockBookingRepository();
      final bookings = [
        Booking.empty().copyWith(id: '1'),
        Booking.empty().copyWith(id: '2'),
      ];
      final booking = bookings.first;
      when(
        () => mockRepository.getConfirmedBookingList(),
      ).thenAnswer((_) async => bookings.sublist(0));

      final provider = ConfirmedBookingListProvider(
        bookingRepository: mockRepository,
      );
      await provider.loadConfirmedBooking();
      final result = await provider.deleteBooking(booking);

      expect(result, true);
      expect(
        provider.state.maybeWhen(data: (data) => data, orElse: () => []),
        bookings.skip(1),
      );
    });

    test('updateBooking updates a booking in the list', () async {
      final mockRepository = MockBookingRepository();
      final bookings = [
        Booking.empty().copyWith(id: '1'),
        Booking.empty().copyWith(id: '2'),
      ];
      final booking = bookings.first.copyWith(reason: 'Updated');
      when(
        () => mockRepository.getConfirmedBookingList(),
      ).thenAnswer((_) async => bookings.sublist(0));

      final provider = ConfirmedBookingListProvider(
        bookingRepository: mockRepository,
      );
      await provider.loadConfirmedBooking();
      final result = await provider.updateBooking(booking);

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        booking,
        ...bookings.skip(1),
      ]);
    });
  });
}
