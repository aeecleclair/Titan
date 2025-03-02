import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/event/providers/confirmed_event_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;

class MockEventRepository extends Mock implements Openapi {}

void main() {
  group('ConfirmedEventListProvider', () {
    late MockEventRepository mockRepository;
    late ConfirmedEventListProvider provider;
    final events = [
      EventComplete.fromJson({}).copyWith(id: '1'),
      EventComplete.fromJson({}).copyWith(id: '2'),
    ];
    final newEvent = EventComplete.fromJson({}).copyWith(id: '3');

    setUp(() {
      mockRepository = MockEventRepository();
      provider = ConfirmedEventListProvider(eventRepository: mockRepository);
    });

    test('loadConfirmedEvent returns expected data', () async {
      when(() => mockRepository.calendarEventsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          events,
        ),
      );

      final result = await provider.loadConfirmedEvent();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        events,
      );
    });

    test('loadConfirmedEvent handles error', () async {
      when(() => mockRepository.calendarEventsConfirmedGet())
          .thenThrow(Exception('Failed to load events'));

      final result = await provider.loadConfirmedEvent();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });

    test('addEvent adds an event to the list', () async {
      when(() => mockRepository.calendarEventsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          events,
        ),
      );

      await provider.loadConfirmedEvent();
      final result = await provider.addEvent(newEvent);

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
      when(() => mockRepository.calendarEventsConfirmedGet())
          .thenThrow(Exception('Failed to add event'));

      final result = await provider.addEvent(newEvent);

      expect(result, false);
    });

    test('deleteEvent removes an event from the list', () async {
      when(() => mockRepository.calendarEventsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          events,
        ),
      );

      await provider.loadConfirmedEvent();
      final result = await provider.deleteEvent(events.first);

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
      when(() => mockRepository.calendarEventsConfirmedGet())
          .thenThrow(Exception('Failed to delete event'));

      final result = await provider.deleteEvent(events.first);

      expect(result, false);
    });
  });
}
