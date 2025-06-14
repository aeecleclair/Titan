import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/event/class/event.dart';
import 'package:titan/event/providers/confirmed_event_list_provider.dart';
import 'package:titan/event/repositories/event_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockEventRepository extends Mock implements EventRepository {}

void main() {
  late ConfirmedEventListProvider confirmedEventListProvider;
  late MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    confirmedEventListProvider = ConfirmedEventListProvider(
      eventRepository: mockEventRepository,
    );
  });

  group('ConfirmedEventListProvider', () {
    final event1 = Event.empty().copyWith(id: '1', name: 'Event 1');
    final event2 = Event.empty().copyWith(id: '2', name: 'Event 2');
    final event3 = Event.empty().copyWith(id: '3', name: 'Event 3');

    test('loadConfirmedEvent returns AsyncValue with list of events', () async {
      when(
        () => mockEventRepository.getConfirmedEventList(),
      ).thenAnswer((_) async => [event1, event2, event3]);

      final result = await confirmedEventListProvider.loadConfirmedEvent();

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
      final newEvent = Event.empty().copyWith(id: '4', name: 'Event 4');
      confirmedEventListProvider.state = AsyncValue.data([event1, event2]);

      final result = await confirmedEventListProvider.addEvent(newEvent);

      expect(result, true);
      expect(
        confirmedEventListProvider.state.when(
          data: (data) => data,
          loading: () => [],
          error: (_, _) => [],
        ),
        [event1, event2, newEvent],
      );
    });

    test('deleteEvent removes event from list', () async {
      confirmedEventListProvider.state = AsyncValue.data([
        event1,
        event2,
        event3,
      ]);

      final result = await confirmedEventListProvider.deleteEvent(event2);

      expect(result, true);
      expect(
        confirmedEventListProvider.state.when(
          data: (data) => data,
          loading: () => [],
          error: (_, _) => [],
        ),
        [event1, event3],
      );
    });
  });
}
