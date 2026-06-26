import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:titan/event/adapters/event_complete_ticket_url.dart';
import 'package:titan/event/providers/event_list_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class MockEventRepository extends Mock implements Openapi {}

void main() {
  group('EventListNotifier', () {
    late MockEventRepository mockRepository;
    late ProviderContainer container;
    late EventListNotifier provider;
    final events = [
      EventCompleteTicketUrl.empty().copyWith(id: '1'),
      EventCompleteTicketUrl.empty().copyWith(id: '2'),
    ];
    final newEvent = EventCompleteTicketUrl.empty().copyWith(id: '3');
    final updatedEvent = events.first.copyWith(name: 'Updated Event');

    setUp(() async {
      mockRepository = MockEventRepository();
      // Default stub for the build()-time auto-load.
      when(() => mockRepository.calendarEventsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          <EventCompleteTicketUrl>[],
        ),
      );
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
      provider = container.read(eventListProvider.notifier);
      await Future(() {}); // let build()'s auto-load settle
    });

    tearDown(() => container.dispose());

    test('loadEventList returns expected data', () async {
      when(() => mockRepository.calendarEventsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), events),
      );

      final result = await provider.loadEventList();

      expect(result.maybeWhen(data: (data) => data, orElse: () => []), events);
    });

    test('loadEventList handles error', () async {
      when(
        () => mockRepository.calendarEventsGet(),
      ).thenThrow(Exception('Failed to load events'));

      final result = await provider.loadEventList();

      expect(
        result.maybeWhen(error: (error, _) => error, orElse: () => null),
        isA<Exception>(),
      );
    });

    test('addEvent adds an event to the list', () async {
      when(() => mockRepository.calendarEventsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), events),
      );
      when(
        () => mockRepository.calendarEventsPost(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), newEvent),
      );

      provider.state = AsyncValue.data([...events]);
      final result = await provider.addEvent(newEvent.toEventBaseCreation());

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        ...events,
        newEvent,
      ]);
    });

    test('addEvent handles error', () async {
      when(
        () => mockRepository.calendarEventsPost(body: any(named: 'body')),
      ).thenThrow(Exception('Failed to add event'));

      provider.state = AsyncValue.data([...events]);
      final result = await provider.addEvent(newEvent.toEventBaseCreation());

      expect(result, false);
    });

    test('updateEvent updates an event in the list', () async {
      when(() => mockRepository.calendarEventsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), events),
      );
      when(
        () => mockRepository.calendarEventsEventIdPatch(
          eventId: any(named: 'eventId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), updatedEvent),
      );

      provider.state = AsyncValue.data([...events]);
      final result = await provider.updateEvent(updatedEvent);

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        updatedEvent,
        ...events.skip(1),
      ]);
    });

    test('updateEvent handles error', () async {
      when(
        () => mockRepository.calendarEventsEventIdPatch(
          eventId: any(named: 'eventId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update event'));

      provider.state = AsyncValue.data([...events]);
      final result = await provider.updateEvent(updatedEvent);

      expect(result, false);
    });

    test('deleteEvent removes an event from the list', () async {
      when(() => mockRepository.calendarEventsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), events),
      );
      when(
        () => mockRepository.calendarEventsEventIdDelete(
          eventId: any(named: 'eventId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), null),
      );

      provider.state = AsyncValue.data([...events]);
      final result = await provider.deleteEvent(events.first);

      expect(result, true);
      expect(
        provider.state.maybeWhen(data: (data) => data, orElse: () => []),
        events.skip(1).toList(),
      );
    });

    test('deleteEvent handles error', () async {
      when(
        () => mockRepository.calendarEventsEventIdDelete(
          eventId: events.first.id,
        ),
      ).thenThrow(Exception('Failed to delete event'));

      provider.state = AsyncValue.data([...events]);
      final result = await provider.deleteEvent(events.first);

      expect(result, false);
    });

    test('toggleConfirmed confirms an event', () async {
      when(() => mockRepository.calendarEventsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), events),
      );
      when(
        () => mockRepository.calendarEventsEventIdReplyDecisionPatch(
          eventId: any(named: 'eventId'),
          decision: any(named: 'decision'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), updatedEvent),
      );

      provider.state = AsyncValue.data([...events]);
      final result = await provider.toggleConfirmed(updatedEvent);

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        updatedEvent,
        ...events.skip(1),
      ]);
    });

    test('toggleConfirmed handles error', () async {
      when(
        () => mockRepository.calendarEventsEventIdReplyDecisionPatch(
          eventId: any(named: 'eventId'),
          decision: any(named: 'decision'),
        ),
      ).thenThrow(Exception('Failed to confirm event'));

      final result = await provider.toggleConfirmed(updatedEvent);

      expect(result, false);
    });
  });
}
