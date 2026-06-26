import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/booking/providers/booking_provider.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

void main() {
  group('BookingNotifier', () {
    late ProviderContainer container;
    late BookingNotifier bookingNotifier;
    final booking = BookingReturnApplicant.empty().copyWith(
      id: '123',
      reason: 'Meeting',
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 1)),
      roomId: 'room1',
    );

    setUp(() {
      container = ProviderContainer();
      bookingNotifier = container.read(bookingProvider.notifier);
    });

    tearDown(() => container.dispose());

    test('initial state is empty booking', () {
      expect(bookingNotifier.state, isA<BookingReturnApplicant>());
      expect(bookingNotifier.state.id, BookingReturnApplicant.empty().id);
    });

    test('setBooking updates state', () {
      bookingNotifier.setBooking(booking);
      expect(bookingNotifier.state, booking);
    });
  });

  group('bookingProvider', () {
    final booking = BookingReturnApplicant.empty().copyWith(
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
      expect(booking.id, BookingReturnApplicant.empty().id);
    });

    test('setBooking updates booking', () {
      final container = ProviderContainer();
      container.read(bookingProvider.notifier).setBooking(booking);
      expect(container.read(bookingProvider), booking);
    });
  });
}
