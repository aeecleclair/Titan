import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:titan/booking/providers/confirmed_booking_list_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class MockBookingRepository extends Mock implements Openapi {}

void main() {
  group('ConfirmedBookingListProvider', () {
    late MockBookingRepository mockRepository;
    late ProviderContainer container;
    late ConfirmedBookingListProvider provider;

    setUp(() async {
      mockRepository = MockBookingRepository();
      when(
        () => mockRepository.bookingBookingsConfirmedGet(),
      ).thenThrow(Exception('Failed to load bookings'));
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
      provider = container.read(confirmedBookingListProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('loadConfirmedBooking returns expected data', () async {
      final bookings = [
        BookingReturnSimpleApplicant.empty().copyWith(id: '1'),
        BookingReturnSimpleApplicant.empty().copyWith(id: '2'),
      ];
      when(() => mockRepository.bookingBookingsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), bookings),
      );

      final result = await provider.loadConfirmedBooking();

      expect(
        result.maybeWhen(data: (data) => data, orElse: () => []),
        bookings,
      );
    });

    test('loadConfirmedBooking handles error', () async {
      when(
        () => mockRepository.bookingBookingsConfirmedGet(),
      ).thenThrow(Exception('Failed to load bookings'));

      final result = await provider.loadConfirmedBooking();

      expect(
        result.maybeWhen(error: (error, _) => error, orElse: () => null),
        isA<Exception>(),
      );
    });

    test('loadConfirmedBooking handles error', () async {
      when(
        () => mockRepository.bookingBookingsConfirmedGet(),
      ).thenThrow(Exception('Failed to load bookings'));

      final result = await provider.loadConfirmedBooking();

      expect(
        result.maybeWhen(error: (error, _) => error, orElse: () => null),
        isA<Exception>(),
      );
    });

    test('addBooking adds a booking to the list', () async {
      final bookings = [
        BookingReturnSimpleApplicant.empty().copyWith(id: '1'),
        BookingReturnSimpleApplicant.empty().copyWith(id: '2'),
      ];
      final newBooking = BookingReturn.empty().copyWith(
        id: '3',
        reason: 'New booking',
      );
      final newBookingSimple = BookingReturnSimpleApplicant.empty().copyWith(
        id: '3',
      );
      when(() => mockRepository.bookingBookingsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), bookings),
      );
      when(
        () => mockRepository.bookingBookingsPost(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), newBooking),
      );

      provider.state = AsyncValue.data([...bookings]);
      final result = await provider.addBooking(newBookingSimple);

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        ...bookings,
        newBookingSimple,
      ]);
    });

    test('addBooking handles error', () async {
      final newBookingSimple = BookingReturnSimpleApplicant.empty().copyWith(
        id: '3',
      );
      when(
        () => mockRepository.bookingBookingsPost(body: any(named: 'body')),
      ).thenThrow(Exception('Failed to add booking'));

      await provider.loadConfirmedBooking();
      final result = await provider.addBooking(newBookingSimple);

      expect(result, false);
    });

    test('addBooking handles error', () async {
      final newBookingSimple = BookingReturnSimpleApplicant.empty().copyWith(
        id: '3',
      );
      when(
        () => mockRepository.bookingBookingsPost(body: any(named: 'body')),
      ).thenThrow(Exception('Failed to add booking'));

      await provider.loadConfirmedBooking();
      final result = await provider.addBooking(newBookingSimple);

      expect(result, false);
    });

    test('addBooking handles error', () async {
      final newBookingSimple = BookingReturnSimpleApplicant.empty().copyWith(
        id: '3',
      );
      when(
        () => mockRepository.bookingBookingsPost(body: any(named: 'body')),
      ).thenThrow(Exception('Failed to add booking'));

      final result = await provider.addBooking(newBookingSimple);

      expect(result, false);
    });

    test('deleteBooking removes a booking from the list', () async {
      final bookings = [
        BookingReturnSimpleApplicant.empty().copyWith(id: '1'),
        BookingReturnSimpleApplicant.empty().copyWith(id: '2'),
      ];
      final booking = bookings.first;
      when(() => mockRepository.bookingBookingsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), bookings),
      );
      when(
        () => mockRepository.bookingBookingsBookingIdDelete(
          bookingId: any(named: 'bookingId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), null),
      );

      provider.state = AsyncValue.data([...bookings]);
      final result = await provider.deleteBooking(booking);

      expect(result, true);
      expect(
        provider.state.maybeWhen(data: (data) => data, orElse: () => []),
        bookings.skip(1).toList(),
      );
    });

    test('deleteBooking handles error', () async {
      final booking = BookingReturnSimpleApplicant.empty().copyWith(id: '1');
      when(
        () => mockRepository.bookingBookingsBookingIdDelete(
          bookingId: booking.id,
        ),
      ).thenThrow(Exception('Failed to delete booking'));

      final result = await provider.deleteBooking(booking);

      expect(result, false);
    });

    test('updateBooking updates a booking in the list', () async {
      final bookings = [
        BookingReturnSimpleApplicant.empty().copyWith(id: '1'),
        BookingReturnSimpleApplicant.empty().copyWith(id: '2'),
      ];
      final updatedBooking = bookings.first.copyWith(reason: 'Updated');
      when(() => mockRepository.bookingBookingsConfirmedGet()).thenAnswer(
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

      provider.state = AsyncValue.data([...bookings]);
      final result = await provider.updateBooking(updatedBooking);

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        updatedBooking,
        ...bookings.skip(1),
      ]);
    });

    test('updateBooking handles error', () async {
      final updatedBooking = BookingReturnSimpleApplicant.empty().copyWith(
        id: '1',
        reason: 'Updated',
      );
      when(
        () => mockRepository.bookingBookingsBookingIdPatch(
          bookingId: any(named: 'bookingId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update booking'));

      final result = await provider.updateBooking(updatedBooking);

      expect(result, false);
    });
  });
}
