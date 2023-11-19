// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/providers/event_page_provider.dart';

void main() {
  group('EventPageProvider', () {
    test('initial state should be EventPage.main', () {
      final container = ProviderContainer();
      final eventPage = container.read(eventPageProvider.notifier);
      expect(eventPage.state, EventPage.main);
    });

    test('setEventPage should update state', () {
      final container = ProviderContainer();
      final eventPage = container.read(eventPageProvider.notifier);

      eventPage.setEventPage(EventPage.admin);

      expect(eventPage.state, EventPage.admin);
    });
  });
}
