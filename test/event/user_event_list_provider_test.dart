import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/event/adapters/event_complete_ticket_url.dart';
import 'package:titan/event/providers/user_event_list_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;
import 'package:titan/tools/repository/repository.dart';

class MockEventRepository extends Mock implements Openapi {}

void main() {
  group('EventEventListProvider', () {
    late MockEventRepository mockRepository;
    late ProviderContainer container;
    late EventEventListProvider provider;
    final events = [
      EventCompleteTicketUrl.empty().copyWith(id: '1'),
      EventCompleteTicketUrl.empty().copyWith(id: '2'),
    ];
    final newEvent = EventCompleteTicketUrl.empty().copyWith(id: '3');
    final updatedEvent = events.first.copyWith(name: 'Updated Event');

    setUp(() async {
      mockRepository = MockEventRepository();
      when(() => mockRepository.calendarEventsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          <EventCompleteTicketUrl>[],
        ),
      );
      container = ProviderContainer(
        overrides: [
          repositoryProvider.overrideWithValue(mockRepository),
          // Keep idProvider unresolved so build()'s whenData auto-load
          // never overwrites the state the tests set manually.
          idProvider.overrideWith((ref) => Completer<String>().future),
        ],
      );
      provider = container.read(eventEventListProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('loadConfirmedEvent returns expected data', () async {
      when(() => mockRepository.calendarEventsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), events),
      );

      final result = await provider.loadConfirmedEvent();

      expect(result.maybeWhen(data: (data) => data, orElse: () => []), events);
    });

    test('loadConfirmedEvent handles error', () async {
      when(
        () => mockRepository.calendarEventsConfirmedGet(),
      ).thenThrow(Exception('Failed to load events'));

      final result = await provider.loadConfirmedEvent();

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
  });
}
