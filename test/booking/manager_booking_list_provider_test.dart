import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/booking/providers/manager_booking_list_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;
import 'package:myecl/tools/builders/empty_models.dart';

class MockBookingRepository extends Mock implements Openapi {}

void main() {
  group('ManagerBookingListProvider', () {
    late MockBookingRepository mockRepository;
    late ManagerBookingListProvider provider;
    final bookings = [
      EmptyModels.empty<BookingReturnApplicant>().copyWith(id: '1'),
      EmptyModels.empty<BookingReturnApplicant>().copyWith(id: '2'),
    ];
    final updatedBooking = bookings.first.copyWith(reason: 'Updated');
    final booking = bookings.first.copyWith(decision: Decision.approved);

    setUp(() {
      mockRepository = MockBookingRepository();
      provider = ManagerBookingListProvider(bookingRepository: mockRepository);
    });

    test('loadUserManageBookings returns expected data', () async {
      when(() => mockRepository.bookingBookingsUsersMeManageGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          bookings,
        ),
      );

      final result = await provider.loadUserManageBookings();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        bookings,
      );
    });

    test('loadUserManageBookings handles error', () async {
      when(() => mockRepository.bookingBookingsUsersMeManageGet())
          .thenThrow(Exception('Failed to load bookings'));

      final result = await provider.loadUserManageBookings();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });
    test('updateBooking updates a booking in the list', () async {
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

      provider.state = AsyncValue.data(bookings);
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
      when(
        () => mockRepository.bookingBookingsBookingIdPatch(
          bookingId: any(named: 'bookingId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update booking'));

      final result = await provider.updateBooking(updatedBooking);

      expect(result, false);
    });

    test('toggleConfirmed confirms a booking', () async {
      when(
        () => mockRepository.bookingBookingsBookingIdReplyDecisionPatch(
          bookingId: any(named: 'bookingId'),
          decision: any(named: 'decision'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          booking,
        ),
      );

      provider.state = AsyncValue.data(bookings);
      final result = await provider.toggleConfirmed(booking, Decision.approved);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [booking, ...bookings.skip(1)],
      );
    });

    test('toggleConfirmed handles error', () async {
      when(
        () => mockRepository.bookingBookingsBookingIdPatch(
          bookingId: any(named: 'bookingId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to confirm booking'));

      provider.state = AsyncValue.data(bookings);
      final result = await provider.toggleConfirmed(booking, Decision.approved);

      expect(result, false);
    });
  });
}
