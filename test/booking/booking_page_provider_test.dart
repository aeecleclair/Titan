// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';

void main() {
  group('BookingPageProvider', () {
    test('BookingPageProvider initial state is BookingPage.main', () {
      final provider = BookingPageProvider();
      expect(provider.state, BookingPage.main);
    });

    test('setBookingPage changes the state of BookingPageProvider', () {
      final provider = BookingPageProvider();
      provider.setBookingPage(BookingPage.admin);
      expect(provider.state, BookingPage.admin);
    });

    test('bookingPageProvider returns the correct state', () {
      final container = ProviderContainer();
      final provider = container.read(bookingPageProvider.notifier);
      expect(container.read(bookingPageProvider), BookingPage.main);
      provider.setBookingPage(BookingPage.admin);
      expect(container.read(bookingPageProvider), BookingPage.admin);
    });
  });
}
