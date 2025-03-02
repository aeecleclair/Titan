import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/providers/event_provider.dart';
import 'package:myecl/generated/openapi.enums.swagger.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

void main() {
  group('EventNotifier', () {
    late ProviderContainer container;
    late EventNotifier notifier;
    final event = EventReturn(
      id: '1',
      name: 'Test Event',
      organizer: 'Organizer',
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 2)),
      allDay: false,
      location: 'Location',
      type: CalendarEventType.eventAe,
      description: 'Description',
      applicantId: '123',
      decision: Decision.approved,
      applicant: EventApplicant(
        id: '123',
        name: 'Applicant',
        firstname: 'First',
        email: 'applicant@example.com',
        accountType: AccountType.$external,
        schoolId: 'school123',
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
      notifier.setEvent(EventReturn.fromJson({}));

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
