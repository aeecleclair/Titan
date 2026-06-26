import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:titan/event/providers/confirmed_event_list_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class MockEventRepository extends Mock implements Openapi {}

void main() {
  group('ConfirmedEventListProvider', () {
    late MockEventRepository mockRepository;
    late ProviderContainer container;
    late ConfirmedEventListProvider provider;
    final events = [
      EventCompleteTicketUrl.empty().copyWith(id: '1'),
      EventCompleteTicketUrl.empty().copyWith(id: '2'),
    ];
    final newEvent = EventCompleteTicketUrl.empty().copyWith(id: '3');

    setUp(() async {
      mockRepository = MockEventRepository();
      when(() => mockRepository.calendarEventsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          <EventCompleteTicketUrl>[],
        ),
      );
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
      provider = container.read(confirmedEventListProvider.notifier);
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
      when(() => mockRepository.calendarEventsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), events),
      );

      provider.state = AsyncValue.data([...events]);
      final result = await provider.addEvent(newEvent);

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        ...events,
        newEvent,
      ]);
    });

    test('addEvent handles error', () async {
      // localAdd cannot mutate while the list is not yet loaded.
      provider.state = const AsyncValue.loading();
      final result = await provider.addEvent(newEvent);

      expect(result, false);
    });

    test('deleteEvent removes an event from the list', () async {
      when(() => mockRepository.calendarEventsConfirmedGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), [...events]),
      );

      await provider.loadConfirmedEvent();
      final result = await provider.deleteEvent(events.first);

      expect(result, true);
      expect(
        provider.state.maybeWhen(data: (data) => data, orElse: () => []),
        events.skip(1).toList(),
      );
    });

    test('deleteEvent handles error', () async {
      // localDelete cannot mutate while the list is not yet loaded.
      provider.state = const AsyncValue.loading();
      final result = await provider.deleteEvent(events.first);

      expect(result, false);
    });
  });
}
