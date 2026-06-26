import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:titan/booking/adapters/booking_return_applicant.dart';
import 'package:titan/booking/providers/user_booking_list_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class MockBookingRepository extends Mock implements Openapi {}

void main() {
  group('UserBookingListProvider', () {
    late MockBookingRepository mockRepository;
    late ProviderContainer container;
    late UserBookingListProvider provider;
    final bookings = [
      BookingReturn.empty().copyWith(id: '1'),
      BookingReturn.empty().copyWith(id: '2'),
    ];
    final newBooking = BookingReturn.empty().copyWith(id: '3');
    final updatedBooking = bookings.first.copyWith(reason: 'Updated');

    setUp(() async {
      mockRepository = MockBookingRepository();
      when(
        () => mockRepository.bookingBookingsUsersMeGet(),
      ).thenThrow(Exception('Failed to load bookings'));
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
      provider = container.read(userBookingListProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('loadUserBookings returns expected data', () async {
      when(() => mockRepository.bookingBookingsUsersMeGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), bookings),
      );

      final result = await provider.loadUserBookings();

      expect(
        result.maybeWhen(data: (data) => data, orElse: () => []),
        bookings,
      );
    });

    test('loadUserBookings handles error', () async {
      when(
        () => mockRepository.bookingBookingsUsersMeGet(),
      ).thenThrow(Exception('Failed to load bookings'));

      final result = await provider.loadUserBookings();

      expect(
        result.maybeWhen(error: (error, _) => error, orElse: () => null),
        isA<Exception>(),
      );
    });

    test('addBooking adds a booking to the list', () async {
      when(() => mockRepository.bookingBookingsUsersMeGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), bookings),
      );
      when(
        () => mockRepository.bookingBookingsPost(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), newBooking),
      );

      provider.state = AsyncValue.data([...bookings]);
      final result = await provider.addBooking(newBooking.toBookingBase());

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        ...bookings,
        newBooking,
      ]);
    });

    test('addBooking handles error', () async {
      when(
        () => mockRepository.bookingBookingsPost(body: any(named: 'body')),
      ).thenThrow(Exception('Failed to add booking'));

      provider.state = AsyncValue.data([...bookings]);
      final result = await provider.addBooking(newBooking.toBookingBase());

      expect(result, false);
    });

    test('updateBooking updates a booking in the list', () async {
      when(() => mockRepository.bookingBookingsUsersMeGet()).thenAnswer(
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
      when(
        () => mockRepository.bookingBookingsBookingIdPatch(
          bookingId: any(named: 'bookingId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update booking'));

      provider.state = AsyncValue.data([...bookings]);
      final result = await provider.updateBooking(updatedBooking);

      expect(result, false);
    });

    test('deleteBooking removes a booking from the list', () async {
      when(() => mockRepository.bookingBookingsUsersMeGet()).thenAnswer(
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
      final result = await provider.deleteBooking(bookings.first);

      expect(result, true);
      expect(
        provider.state.maybeWhen(data: (data) => data, orElse: () => []),
        bookings.skip(1).toList(),
      );
    });

    test('deleteBooking handles error', () async {
      when(
        () => mockRepository.bookingBookingsBookingIdDelete(
          bookingId: bookings.first.id,
        ),
      ).thenThrow(Exception('Failed to delete booking'));

      provider.state = AsyncValue.data([...bookings]);
      final result = await provider.deleteBooking(bookings.first);

      expect(result, false);
    });
  });
}
