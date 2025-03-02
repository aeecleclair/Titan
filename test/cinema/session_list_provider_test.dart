import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/cinema/adapters/session.dart';
import 'package:myecl/cinema/providers/session_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;

class MockSessionRepository extends Mock implements Openapi {}

void main() {
  group('SessionListNotifier', () {
    late MockSessionRepository mockRepository;
    late SessionListNotifier provider;
    final sessions = [
      CineSessionComplete.fromJson({}).copyWith(id: '1'),
      CineSessionComplete.fromJson({}).copyWith(id: '2'),
    ];
    final newSession = CineSessionComplete.fromJson({}).copyWith(id: '3');
    final updatedSession = sessions.first.copyWith(name: 'Updated Session');

    setUp(() {
      mockRepository = MockSessionRepository();
      provider = SessionListNotifier(sessionRepository: mockRepository);
    });

    test('loadSessions returns expected data', () async {
      when(() => mockRepository.cinemaSessionsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          sessions,
        ),
      );

      final result = await provider.loadSessions();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        sessions,
      );
    });

    test('loadSessions handles error', () async {
      when(() => mockRepository.cinemaSessionsGet())
          .thenThrow(Exception('Failed to load sessions'));

      final result = await provider.loadSessions();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });

    test('addSession adds a session to the list', () async {
      when(() => mockRepository.cinemaSessionsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          sessions,
        ),
      );
      when(() => mockRepository.cinemaSessionsPost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          newSession,
        ),
      );

      await provider.loadSessions();
      final result = await provider.addSession(newSession.toCineSessionBase());

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [...sessions, newSession],
      );
    });

    test('addSession handles error', () async {
      when(() => mockRepository.cinemaSessionsPost(body: any(named: 'body')))
          .thenThrow(Exception('Failed to add session'));

      final result = await provider.addSession(newSession.toCineSessionBase());

      expect(result, false);
    });

    test('updateSession updates a session in the list', () async {
      when(() => mockRepository.cinemaSessionsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          sessions,
        ),
      );
      when(
        () => mockRepository.cinemaSessionsSessionIdPatch(
          sessionId: any(named: 'sessionId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          updatedSession,
        ),
      );

      await provider.loadSessions();
      final result = await provider.updateSession(updatedSession);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [updatedSession, ...sessions.skip(1)],
      );
    });

    test('updateSession handles error', () async {
      when(
        () => mockRepository.cinemaSessionsSessionIdPatch(
          sessionId: any(named: 'sessionId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update session'));

      final result = await provider.updateSession(updatedSession);

      expect(result, false);
    });

    test('deleteSession removes a session from the list', () async {
      when(() => mockRepository.cinemaSessionsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          sessions,
        ),
      );
      when(
        () => mockRepository.cinemaSessionsSessionIdDelete(
          sessionId: any(named: 'sessionId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      await provider.loadSessions();
      final result = await provider.deleteSession(sessions.first.id);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        sessions.skip(1).toList(),
      );
    });

    test('deleteSession handles error', () async {
      when(
        () => mockRepository.cinemaSessionsSessionIdDelete(
          sessionId: sessions.first.id,
        ),
      ).thenThrow(Exception('Failed to delete session'));

      final result = await provider.deleteSession(sessions.first.id);

      expect(result, false);
    });
  });
}
