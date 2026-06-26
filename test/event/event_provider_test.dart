import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/event/providers/event_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';

void main() {
  group('EventNotifier', () {
    late ProviderContainer container;
    late EventNotifier notifier;
    final event = EventCompleteTicketUrl(
      id: '1',
      name: 'Test Event',
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 2)),
      allDay: false,
      location: 'Location',
      description: 'Description',
      decision: Decision.approved,
      notification: false,
      associationId: '1',
      association: Association(
        name: "Association Name",
        groupId: 'group1',
        id: '1',
      ),
    );

    setUp(() {
      container = ProviderContainer();
      notifier = container.read(eventProvider.notifier);
    });

    test('setEvent should update state', () {
      notifier.setEvent(event);

      expect(container.read(eventProvider).id, equals('1'));
      expect(container.read(eventProvider).name, equals('Test Event'));
      expect(container.read(eventProvider).location, equals('Location'));
    });

    test('resetEvent should reset state', () {
      notifier.setEvent(event);
      notifier.setEvent(EventCompleteTicketUrl.empty());

      expect(container.read(eventProvider).id, equals(''));
      expect(container.read(eventProvider).name, equals(''));
      expect(container.read(eventProvider).location, equals(''));
    });

    test('setRoom should update location', () {
      notifier.setEvent(event);
      notifier.setRoom('New Location');

      expect(container.read(eventProvider).location, equals('New Location'));
    });
  });
}
