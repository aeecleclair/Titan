import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/cinema/providers/session_list_provider.dart';
import 'package:myecl/cinema/repositories/session_repository.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

void main() {
  group('Testing Session class', () {
    test('Should return a Session', () {
      final session = Session.empty();
      expect(session, isA<Session>());
    });

    test('Should return a Session with the correct values', () {
      final session = Session.empty();
      expect(session.id, equals(''));
      expect(session.name, equals(''));
      expect(session.start, isA<DateTime>());
      expect(session.duration, equals(0));
      expect(session.overview, equals(""));
      expect(session.genre, equals(""));
      expect(session.tagline, equals(""));
    });

    test('Should parse a Session from json', () {
      final session = Session.fromJson({
        "id": "1",
        "name": "Session 1",
        "start": "2021-01-01T00:00:00.000Z",
        "duration": 120,
        "overview": "Overview",
        "genre": "Genre",
        "tagline": "Tagline"
      });
      expect(session, isA<Session>());
      expect(session.id, equals("1"));
      expect(session.name, equals("Session 1"));
      expect(session.start, equals(DateTime.parse("2021-01-01T00:00:00.000Z")));
      expect(session.duration, equals(120));
      expect(session.overview, equals("Overview"));
      expect(session.genre, equals("Genre"));
      expect(session.tagline, equals("Tagline"));
    });

    test('Should return a json from a Session', () {
      final session = Session.fromJson({
        "id": "1",
        "name": "Session 1",
        "start": "2021-01-01T00:00:00.000Z",
        "duration": 120,
        "overview": "Overview",
        "genre": "Genre",
        "tagline": "Tagline"
      });
      expect(
          session.toJson(),
          equals({
            "id": "1",
            "name": "Session 1",
            "start": "2021-01-01T00:00:00.000Z",
            "duration": 120,
            "overview": "Overview",
            "genre": "Genre",
            "tagline": "Tagline"
          }));
    });
  });

  group('Testing SessionListNotifier : loadSession', () {
    test('Should return a list of Session', () async {
      final sessionRepository = MockSessionRepository();
      when(() => sessionRepository.getAllSessions())
          .thenAnswer((_) async => [Session.empty()]);
      final sessionListNotifier =
          SessionListNotifier(sessionRepository: sessionRepository);
      final sessionList = await sessionListNotifier.loadSessions();
      expect(sessionList, isA<AsyncData<List<Session>>>());
      expect(
          sessionList
              .when(
                  data: (data) => data,
                  loading: () => [],
                  error: (error, stackTrace) => [])
              .length,
          1);
    });

    test('Should return an error', () async {
      final sessionRepository = MockSessionRepository();
      when(() => sessionRepository.getAllSessions())
          .thenThrow(Exception('Error'));
      final sessionListNotifier =
          SessionListNotifier(sessionRepository: sessionRepository);
      final sessionList = await sessionListNotifier.loadSessions();
      expect(sessionList, isA<AsyncError<List<Session>>>());
      expect(
          sessionList.maybeWhen(
              error: (error, stackTrace) => error, orElse: () => null),
          isA<Exception>());
    });
  });

  group('Testing SessionListNotifier : addSession', () {
    test('Should create a Session', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(() => sessionRepository.getAllSessions())
          .thenAnswer((_) async => [Session.empty()]);
      when(() => sessionRepository.addSession(newSession))
          .thenAnswer((_) async => newSession);
      final sessionListNotifier =
          SessionListNotifier(sessionRepository: sessionRepository);
      await sessionListNotifier.loadSessions();
      final session = await sessionListNotifier.addSession(newSession);
      expect(session, true);
    });
    
    test('Should return an error if session is not added', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(() => sessionRepository.getAllSessions())
          .thenAnswer((_) async => [Session.empty()]);
      when(() => sessionRepository.addSession(newSession))
          .thenThrow(Exception('Error'));
      final sessionListNotifier =
          SessionListNotifier(sessionRepository: sessionRepository);
      await sessionListNotifier.loadSessions();
      final session = await sessionListNotifier.addSession(newSession);
      expect(session, false);
    });

    test('Should return an error if session is not loaded', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(() => sessionRepository.getAllSessions())
          .thenAnswer((_) async => [Session.empty()]);
      when(() => sessionRepository.addSession(newSession))
          .thenAnswer((_) async => newSession);
      final sessionListNotifier =
          SessionListNotifier(sessionRepository: sessionRepository);
      final session = await sessionListNotifier.addSession(newSession);
      expect(session, false);
    });
  });

  group('Testing SessionListNotifier : updateSession', () {
    test('Should update a Session', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(() => sessionRepository.getAllSessions())
          .thenAnswer((_) async => [newSession]);
      when(() => sessionRepository.updateSession(newSession))
          .thenAnswer((_) async => true);
      final sessionListNotifier =
          SessionListNotifier(sessionRepository: sessionRepository);
      await sessionListNotifier.loadSessions();
      final session = await sessionListNotifier.updateSession(newSession);
      expect(session, true);
    });
    
    test('Should return an error if session is not updated', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(() => sessionRepository.getAllSessions())
          .thenAnswer((_) async => [newSession]);
      when(() => sessionRepository.updateSession(newSession))
          .thenThrow(Exception('Error'));
      final sessionListNotifier =
          SessionListNotifier(sessionRepository: sessionRepository);
      await sessionListNotifier.loadSessions();
      final session = await sessionListNotifier.updateSession(newSession);
      expect(session, false);
    });

    test('Should return an error if session is not loaded', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(() => sessionRepository.getAllSessions())
          .thenAnswer((_) async => [newSession]);
      when(() => sessionRepository.updateSession(newSession))
          .thenAnswer((_) async => true);
      final sessionListNotifier =
          SessionListNotifier(sessionRepository: sessionRepository);
      final session = await sessionListNotifier.updateSession(newSession);
      expect(session, false);
    });

    test('Should return an error if session is not found', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(() => sessionRepository.getAllSessions())
          .thenAnswer((_) async => [Session.empty()]);
      when(() => sessionRepository.updateSession(newSession))
          .thenAnswer((_) async => false);
      final sessionListNotifier =
          SessionListNotifier(sessionRepository: sessionRepository);
      await sessionListNotifier.loadSessions();
      final session = await sessionListNotifier.updateSession(newSession);
      expect(session, false);
    });
  });

  group('Testing SessionListNotifier : deleteSession', () {
    test('Should delete a Session', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(() => sessionRepository.getAllSessions())
          .thenAnswer((_) async => [newSession]);
      when(() => sessionRepository.deleteSession(newSession.id))
          .thenAnswer((_) async => true);
      final sessionListNotifier =
          SessionListNotifier(sessionRepository: sessionRepository);
      await sessionListNotifier.loadSessions();
      final session = await sessionListNotifier.deleteSession(newSession);
      expect(session, true);
    });
    
    test('Should return an error if session is not deleted', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(() => sessionRepository.getAllSessions())
          .thenAnswer((_) async => [newSession]);
      when(() => sessionRepository.deleteSession(newSession.id))
          .thenThrow(Exception('Error'));
      final sessionListNotifier =
          SessionListNotifier(sessionRepository: sessionRepository);
      await sessionListNotifier.loadSessions();
      final session = await sessionListNotifier.deleteSession(newSession);
      expect(session, false);
    });

    test('Should return an error if session is not loaded', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(() => sessionRepository.getAllSessions())
          .thenAnswer((_) async => [newSession]);
      when(() => sessionRepository.deleteSession(newSession.id))
          .thenAnswer((_) async => true);
      final sessionListNotifier =
          SessionListNotifier(sessionRepository: sessionRepository);
      final session = await sessionListNotifier.deleteSession(newSession);
      expect(session, false);
    });

    test('Should return an error if session is not found', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(() => sessionRepository.getAllSessions())
          .thenAnswer((_) async => [Session.empty()]);
      when(() => sessionRepository.deleteSession(newSession.id))
          .thenAnswer((_) async => false);
      final sessionListNotifier =
          SessionListNotifier(sessionRepository: sessionRepository);
      await sessionListNotifier.loadSessions();
      final session = await sessionListNotifier.deleteSession(newSession);
      expect(session, false);
    });
  });
}
