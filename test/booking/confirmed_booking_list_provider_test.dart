import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/generated/client_index.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class MockBookingRepository extends Mock implements Openapi {}

void main() {
  group('ConfirmedBookingListProvider', () {
    test('loadConfirmedBooking returns expected data', () async {
      final mockRepository = MockBookingRepository();
      final bookings = [
        EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '1'),
        EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '2'),
      ];
      when(() => mockRepository.bookingBookingsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          bookings,
        ),
      );

      final provider =
          ConfirmedBookingListProvider(bookingRepository: mockRepository);
      final result = await provider.loadConfirmedBooking();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        bookings,
      );
    });

    test('loadConfirmedBooking handles error', () async {
      final mockRepository = MockBookingRepository();
      when(() => mockRepository.bookingBookingsConfirmedGet())
          .thenThrow(Exception('Failed to load bookings'));

      final provider =
          ConfirmedBookingListProvider(bookingRepository: mockRepository);
      final result = await provider.loadConfirmedBooking();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });

    test('addBooking adds a booking to the list', () async {
      final mockRepository = MockBookingRepository();
      final bookings = [
        EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '1'),
        EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '2'),
      ];
      final newBookingSimple =
          EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '3');

      final provider =
          ConfirmedBookingListProvider(bookingRepository: mockRepository);
      provider.state = AsyncValue.data([...bookings]);
      final result = await provider.addBooking(newBookingSimple);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [...bookings, newBookingSimple],
      );
    });

    test('deleteBooking removes a booking from the list', () async {
      final mockRepository = MockBookingRepository();
      final bookings = [
        EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '1'),
        EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '2'),
      ];
      final booking = bookings.first;

      final provider =
          ConfirmedBookingListProvider(bookingRepository: mockRepository);
      provider.state = AsyncValue.data([...bookings]);
      final result = await provider.deleteBooking(booking);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        bookings.skip(1).toList(),
      );
    });

    test('updateBooking updates a booking in the list', () async {
      final mockRepository = MockBookingRepository();
      final bookings = [
        EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '1'),
        EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '2'),
      ];
      final updatedBooking = bookings.first.copyWith(reason: 'Updated');

      final provider =
          ConfirmedBookingListProvider(bookingRepository: mockRepository);
      provider.state = AsyncValue.data([...bookings]);
      final result = await provider.updateBooking(updatedBooking);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [updatedBooking, ...bookings.skip(1)],
      );
    });
  });
}
