import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/event/class/event.dart';
import 'package:titan/event/providers/event_list_provider.dart';
import 'package:titan/event/repositories/event_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/tools/functions.dart';

class MockEventRepository extends Mock implements EventRepository {}

void main() {
  group('EventListNotifier', () {
    late EventRepository eventRepository;
    late EventListNotifier eventListNotifier;

    setUp(() {
      eventRepository = MockEventRepository();
      eventListNotifier = EventListNotifier(eventRepository: eventRepository);
    });

    test('loadEventList should return AsyncValue<List<Event>>', () async {
      final events = [
        Event.empty().copyWith(id: '1', name: 'Event 1'),
        Event.empty().copyWith(id: '2', name: 'Event 2'),
      ];
      when(() => eventRepository.getAllEvent()).thenAnswer((_) async => events);

      final result = await eventListNotifier.loadEventList();

      expect(
        result.when(
          data: (data) => data,
          loading: () => [],
          error: (_, _) => [],
        ),
        events,
      );
    });

    test('addEvent should return true', () async {
      final event = Event.empty().copyWith(id: '1', name: 'Event 1');
      when(
        () => eventRepository.createEvent(event),
      ).thenAnswer((_) async => event);
      eventListNotifier.state = AsyncValue.data([event]);
      final result = await eventListNotifier.addEvent(event);

      expect(result, true);
    });

    test('updateEvent should return true', () async {
      final event = Event.empty().copyWith(id: '1', name: 'Event 1');
      when(
        () => eventRepository.updateEvent(event),
      ).thenAnswer((_) async => true);

      eventListNotifier.state = AsyncValue.data([event]);
      final result = await eventListNotifier.updateEvent(event);

      expect(result, true);
    });

    test('deleteEvent should return true', () async {
      final event = Event.empty().copyWith(id: '1', name: 'Event 1');
      when(
        () => eventRepository.deleteEvent(event.id),
      ).thenAnswer((_) async => true);
      eventListNotifier.state = AsyncValue.data([event]);

      final result = await eventListNotifier.deleteEvent(event);

      expect(result, true);
    });

    test('toggleConfirmed should return true', () async {
      final event = Event.empty().copyWith(
        id: '1',
        name: 'Event 1',
        decision: Decision.approved,
      );
      when(
        () => eventRepository.confirmEvent(event),
      ).thenAnswer((_) async => true);
      eventListNotifier.state = AsyncValue.data([event]);

      final result = await eventListNotifier.toggleConfirmed(event);

      expect(result, true);
    });
  });
}
