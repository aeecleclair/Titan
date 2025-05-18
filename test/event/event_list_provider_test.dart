import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/event/adapters/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;
import 'package:myecl/tools/builders/empty_models.dart';

class MockEventRepository extends Mock implements Openapi {}

void main() {
  group('EventListNotifier', () {
    late MockEventRepository mockRepository;
    late EventListNotifier provider;
    final events = [
      EmptyModels.empty<EventReturn>().copyWith(id: '1'),
      EmptyModels.empty<EventReturn>().copyWith(id: '2'),
    ];
    final newEvent = EmptyModels.empty<EventReturn>().copyWith(id: '3');
    final updatedEvent = events.first.copyWith(name: 'Updated Event');

    setUp(() {
      mockRepository = MockEventRepository();
      provider = EventListNotifier(eventRepository: mockRepository);
    });

    test('loadEventList returns expected data', () async {
      when(() => mockRepository.calendarEventsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          events,
        ),
      );

      final result = await provider.loadEventList();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        events,
      );
    });

    test('loadEventList handles error', () async {
      when(() => mockRepository.calendarEventsGet())
          .thenThrow(Exception('Failed to load events'));

      final result = await provider.loadEventList();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });

    test('addEvent adds an event to the list', () async {
      when(() => mockRepository.calendarEventsPost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          newEvent,
        ),
      );

      provider.state = AsyncValue.data([...events]);
      final result = await provider.addEvent(newEvent.toEventBase());

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [...events, newEvent],
      );
    });

    test('addEvent handles error', () async {
      when(() => mockRepository.calendarEventsPost(body: any(named: 'body')))
          .thenThrow(Exception('Failed to add event'));

      provider.state = AsyncValue.data([...events]);
      final result = await provider.addEvent(newEvent.toEventBase());

      expect(result, false);
    });

    test('updateEvent updates an event in the list', () async {
      when(
        () => mockRepository.calendarEventsEventIdPatch(
          eventId: any(named: 'eventId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          updatedEvent,
        ),
      );

      provider.state = AsyncValue.data([...events]);
      final result = await provider.updateEvent(updatedEvent);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [updatedEvent, ...events.skip(1)],
      );
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
      when(
        () => mockRepository.calendarEventsEventIdDelete(
          eventId: any(named: 'eventId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      provider.state = AsyncValue.data([...events]);
      final result = await provider.deleteEvent(events.first.id);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
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
      final result = await provider.deleteEvent(events.first.id);

      expect(result, false);
    });

    test('toggleConfirmed confirms an event', () async {
      when(
        () => mockRepository.calendarEventsEventIdReplyDecisionPatch(
          eventId: any(named: 'eventId'),
          decision: any(named: 'decision'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          updatedEvent,
        ),
      );

      provider.state = AsyncValue.data([...events]);
      final result = await provider.toggleConfirmed(updatedEvent);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [updatedEvent, ...events.skip(1)],
      );
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
