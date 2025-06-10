import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/event/class/event.dart';
import 'package:titan/event/providers/user_event_list_provider.dart';
import 'package:titan/event/repositories/event_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockEventRepository extends Mock implements EventRepository {}

void main() {
  late EventEventListProvider provider;
  late MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    provider = EventEventListProvider(eventRepository: mockEventRepository);
  });

  group('EventEventListProvider', () {
    final event1 = Event.empty().copyWith(id: '1', name: 'Event 1');
    final event2 = Event.empty().copyWith(id: '2', name: 'Event 2');
    final event3 = Event.empty().copyWith(id: '3', name: 'Event 3');

    test('setId sets userId', () {
      provider.setId('123');
      expect(provider.userId, '123');
    });

    test('loadConfirmedEvent loads events from repository', () async {
      when(
        () => mockEventRepository.getUserEventList(provider.userId),
      ).thenAnswer((_) async => [event1, event2, event3]);

      final result = await provider.loadConfirmedEvent();

      expect(
        result.when(
          data: (data) => data,
          loading: () => [],
          error: (_, _) => [],
        ),
        [event1, event2, event3],
      );
    });

    test('addEvent adds event to list', () async {
      when(
        () => mockEventRepository.createEvent(event1),
      ).thenAnswer((_) async => event1);
      provider.state = AsyncValue.data([event2, event3]);
      final result = await provider.addEvent(event1);

      expect(result, true);
      expect(
        provider.state.when(
          data: (data) => data,
          loading: () => [],
          error: (_, _) => [],
        ),
        [event2, event3, event1],
      );
    });

    test('updateEvent updates event in list', () async {
      provider.state = AsyncValue.data([event1, event2, event3]);
      final updatedEvent = Event.empty().copyWith(
        id: '2',
        name: 'Updated Event 2',
      );
      when(
        () => mockEventRepository.updateEvent(updatedEvent),
      ).thenAnswer((_) async => true);

      final result = await provider.updateEvent(updatedEvent);

      expect(result, true);
      expect(
        provider.state.when(
          data: (data) => data,
          loading: () => [],
          error: (_, _) => [],
        ),
        [event1, updatedEvent, event3],
      );
    });

    test('deleteEvent deletes event from list', () async {
      provider.state = AsyncValue.data([event1, event2, event3]);
      when(
        () => mockEventRepository.deleteEvent(event2.id),
      ).thenAnswer((_) async => true);

      final result = await provider.deleteEvent(event2);

      expect(result, true);
      expect(
        provider.state.when(
          data: (data) => data,
          loading: () => [],
          error: (_, _) => [],
        ),
        [event1, event3],
      );
    });
  });
}
