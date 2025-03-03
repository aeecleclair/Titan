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
      final newBooking = EmptyModels.empty<BookingReturn>()
          .copyWith(id: '3', reason: 'New booking');
      final newBookingSimple =
          EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '3');
      when(() => mockRepository.bookingBookingsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          bookings,
        ),
      );
      when(() => mockRepository.bookingBookingsPost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          newBooking,
        ),
      );

      final provider =
          ConfirmedBookingListProvider(bookingRepository: mockRepository);
      await provider.loadConfirmedBooking();
      final result = await provider.addBooking(newBookingSimple);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [...bookings, newBooking],
      );
    });

    test('addBooking handles error', () async {
      final mockRepository = MockBookingRepository();
      final newBookingSimple =
          EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '3');
      when(() => mockRepository.bookingBookingsPost(body: any(named: 'body')))
          .thenThrow(Exception('Failed to add booking'));

      final provider =
          ConfirmedBookingListProvider(bookingRepository: mockRepository);
      final result = await provider.addBooking(newBookingSimple);

      expect(result, false);
    });

    test('deleteBooking removes a booking from the list', () async {
      final mockRepository = MockBookingRepository();
      final bookings = [
        EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '1'),
        EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '2'),
      ];
      final booking = bookings.first;
      when(() => mockRepository.bookingBookingsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          bookings,
        ),
      );
      when(
        () => mockRepository.bookingBookingsBookingIdDelete(
          bookingId: any(named: 'bookingId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      final provider =
          ConfirmedBookingListProvider(bookingRepository: mockRepository);
      await provider.loadConfirmedBooking();
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

    test('deleteBooking handles error', () async {
      final mockRepository = MockBookingRepository();
      final booking =
          EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '1');
      when(
        () => mockRepository.bookingBookingsBookingIdDelete(
          bookingId: booking.id,
        ),
      ).thenThrow(Exception('Failed to delete booking'));

      final provider =
          ConfirmedBookingListProvider(bookingRepository: mockRepository);
      final result = await provider.deleteBooking(booking);

      expect(result, false);
    });

    test('updateBooking updates a booking in the list', () async {
      final mockRepository = MockBookingRepository();
      final bookings = [
        EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '1'),
        EmptyModels.empty<BookingReturnSimpleApplicant>().copyWith(id: '2'),
      ];
      final updatedBooking = bookings.first.copyWith(reason: 'Updated');
      when(() => mockRepository.bookingBookingsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          bookings,
        ),
      );
      when(
        () => mockRepository.bookingBookingsBookingIdPatch(
          bookingId: any(named: 'bookingId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          updatedBooking,
        ),
      );

      final provider =
          ConfirmedBookingListProvider(bookingRepository: mockRepository);
      await provider.loadConfirmedBooking();
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

    test('updateBooking handles error', () async {
      final mockRepository = MockBookingRepository();
      final updatedBooking = EmptyModels.empty<BookingReturnSimpleApplicant>()
          .copyWith(id: '1', reason: 'Updated');
      when(
        () => mockRepository.bookingBookingsBookingIdPatch(
          bookingId: any(named: 'bookingId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update booking'));

      final provider =
          ConfirmedBookingListProvider(bookingRepository: mockRepository);
      final result = await provider.updateBooking(updatedBooking);

      expect(result, false);
    });
  });
}
