import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

void main() {
  group('BookingNotifier', () {
    late BookingNotifier bookingNotifier;
    final booking = EmptyModels.empty<BookingReturnApplicant>().copyWith(
      id: '123',
      reason: 'Meeting',
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 1)),
      roomId: 'room1',
    );

    setUp(() {
      bookingNotifier = BookingNotifier();
    });

    test('initial state is empty booking', () {
      expect(bookingNotifier.state, isA<BookingReturnApplicant>());
      expect(
        bookingNotifier.state.id,
        EmptyModels.empty<BookingReturnApplicant>().id,
      );
    });

    test('setBooking updates state', () {
      bookingNotifier.setBooking(booking);
      expect(bookingNotifier.state, booking);
    });
  });

  group('bookingProvider', () {
    final booking = EmptyModels.empty<BookingReturnApplicant>().copyWith(
      id: '123',
      reason: 'Meeting',
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 1)),
      roomId: 'room1',
    );
    test('should return BookingNotifier instance', () {
      final container = ProviderContainer();
      final bookingNotifier = container.read(bookingProvider.notifier);
      expect(bookingNotifier, isA<BookingNotifier>());
    });

    test('should return empty booking initially', () {
      final container = ProviderContainer();
      final booking = container.read(bookingProvider);
      expect(booking, isA<BookingReturnApplicant>());
      expect(booking.id, EmptyModels.empty<BookingReturnApplicant>().id);
    });

    test('setBooking updates booking', () {
      final container = ProviderContainer();
      container.read(bookingProvider.notifier).setBooking(booking);
      expect(container.read(bookingProvider), booking);
    });
  });
}
