import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/event/class/event.dart';
import 'package:titan/event/providers/event_provider.dart';

void main() {
  group('EventNotifier', () {
    test('should set the event', () {
      final eventNotifier = EventNotifier();
      final event = Event.empty().copyWith(
        id: '1',
        description: 'This is a test event',
      );

      eventNotifier.setEvent(event);

      expect(eventNotifier.state, equals(event));
    });
  });

  group('eventProvider', () {
    test('should return an instance of EventNotifier', () {
      final container = ProviderContainer();
      final eventNotifier = container.read(eventProvider.notifier);

      expect(eventNotifier, isInstanceOf<EventNotifier>());
    });

    test('should return an empty event by default', () {
      final container = ProviderContainer();
      final event = container.read(eventProvider);

      expect(event, isA<Event>());
    });

    test('should set the event', () {
      final container = ProviderContainer();
      final event = Event.empty().copyWith(
        id: '1',
        description: 'This is a test event',
      );

      container.read(eventProvider.notifier).setEvent(event);

      expect(container.read(eventProvider), equals(event));
    });
  });
}
