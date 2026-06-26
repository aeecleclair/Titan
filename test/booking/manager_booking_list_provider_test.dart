import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:titan/booking/providers/manager_booking_list_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class MockBookingRepository extends Mock implements Openapi {}

void main() {
  group('ManagerBookingListProvider', () {
    late MockBookingRepository mockRepository;
    late ProviderContainer container;
    late ManagerBookingListProvider provider;
    final bookings = [
      BookingReturnApplicant.empty().copyWith(id: '1'),
      BookingReturnApplicant.empty().copyWith(id: '2'),
    ];
    final updatedBooking = bookings.first.copyWith(reason: 'Updated');
    final booking = bookings.first.copyWith(decision: Decision.approved);

    setUp(() async {
      mockRepository = MockBookingRepository();
      when(
        () => mockRepository.bookingBookingsUsersMeManageGet(),
      ).thenThrow(Exception('Failed to load bookings'));
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
      provider = container.read(managerBookingListProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('loadUserManageBookings returns expected data', () async {
      when(() => mockRepository.bookingBookingsUsersMeManageGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), bookings),
      );

      final result = await provider.loadUserManageBookings();

      expect(
        result.maybeWhen(data: (data) => data, orElse: () => []),
        bookings,
      );
    });

    test('loadUserManageBookings handles error', () async {
      when(
        () => mockRepository.bookingBookingsUsersMeManageGet(),
      ).thenThrow(Exception('Failed to load bookings'));

      final result = await provider.loadUserManageBookings();

      expect(
        result.maybeWhen(error: (error, _) => error, orElse: () => null),
        isA<Exception>(),
      );
    });
    test('updateBooking updates a booking in the list', () async {
      when(() => mockRepository.bookingBookingsUsersMeManageGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), bookings),
      );
      when(
        () => mockRepository.bookingBookingsBookingIdPatch(
          bookingId: any(named: 'bookingId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async =>
            chopper.Response(http.Response('body', 200), updatedBooking),
      );

      provider.state = AsyncValue.data(bookings);
      final result = await provider.updateBooking(updatedBooking);

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        updatedBooking,
        ...bookings.skip(1),
      ]);
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
      when(() => mockRepository.bookingBookingsUsersMeManageGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), bookings),
      );
      when(
        () => mockRepository.bookingBookingsBookingIdReplyDecisionPatch(
          bookingId: any(named: 'bookingId'),
          decision: any(named: 'decision'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), booking),
      );

      provider.state = AsyncValue.data(bookings);
      final result = await provider.toggleConfirmed(booking, Decision.approved);

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        booking,
        ...bookings.skip(1),
      ]);
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
