import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/event/adapters/event.dart';
import 'package:myecl/event/providers/user_event_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;
import 'package:myecl/tools/builders/empty_models.dart';

class MockEventRepository extends Mock implements Openapi {}

void main() {
  group('EventEventListProvider', () {
    late MockEventRepository mockRepository;
    late EventEventListProvider provider;
    final events = [
      EmptyModels.empty<EventReturn>().copyWith(id: '1'),
      EmptyModels.empty<EventReturn>().copyWith(id: '2'),
    ];
    final newEvent = EmptyModels.empty<EventReturn>().copyWith(id: '3');
    final updatedEvent = events.first.copyWith(name: 'Updated Event');

    setUp(() {
      mockRepository = MockEventRepository();
      provider = EventEventListProvider(eventRepository: mockRepository);
    });

    test('loadConfirmedEvent returns expected data', () async {
      when(
        () => mockRepository.calendarEventsUserApplicantIdGet(
          applicantId: any(named: 'applicantId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          events,
        ),
      );

      final result = await provider.loadConfirmedEvent('123');

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        events,
      );
    });

    test('loadConfirmedEvent handles error', () async {
      when(
        () => mockRepository.calendarEventsUserApplicantIdGet(
          applicantId: any(named: 'applicantId'),
        ),
      ).thenThrow(Exception('Failed to load events'));

      final result = await provider.loadConfirmedEvent('123');

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });

    test('addEvent adds an event to the list', () async {
      when(
        () => mockRepository.calendarEventsUserApplicantIdGet(
          applicantId: any(named: 'applicantId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          events,
        ),
      );
      when(() => mockRepository.calendarEventsPost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          newEvent,
        ),
      );

      await provider.loadConfirmedEvent('123');
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

      final result = await provider.addEvent(newEvent.toEventBase());

      expect(result, false);
    });

    test('updateEvent updates an event in the list', () async {
      when(
        () => mockRepository.calendarEventsUserApplicantIdGet(
          applicantId: any(named: 'applicantId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          events,
        ),
      );
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

      await provider.loadConfirmedEvent('123');
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

      final result = await provider.updateEvent(updatedEvent);

      expect(result, false);
    });

    test('deleteEvent removes an event from the list', () async {
      when(
        () => mockRepository.calendarEventsUserApplicantIdGet(
          applicantId: any(named: 'applicantId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          events,
        ),
      );
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

      await provider.loadConfirmedEvent('123');
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

      final result = await provider.deleteEvent(events.first.id);

      expect(result, false);
    });
  });
}
