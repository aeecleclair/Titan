import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/booking/providers/booking_provider.dart';

void main() {
  group('BookingNotifier', () {
    test('setBooking should update state', () {
      final bookingNotifier = BookingNotifier();
      final booking = Booking.empty().copyWith(id: '123');

      bookingNotifier.setBooking(booking);

      expect(bookingNotifier.state, equals(booking));
    });
  });

  group('bookingProvider', () {
    test('should return BookingNotifier instance', () {
      final container = ProviderContainer();
      final booking = container.read(bookingProvider);

      expect(booking, isA<Booking>());
    });
  });
}
