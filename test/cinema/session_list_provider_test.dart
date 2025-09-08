import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/cinema/class/session.dart';
import 'package:titan/cinema/providers/session_list_provider.dart';
import 'package:titan/cinema/repositories/session_repository.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

void main() {
  group('SessionListNotifier', () {
    test('Should return a list of Session', () async {
      final sessionRepository = MockSessionRepository();
      when(
        () => sessionRepository.getAllSessions(),
      ).thenAnswer((_) async => [Session.empty()]);
      final sessionListNotifier = SessionListNotifier(
        sessionRepository: sessionRepository,
      );
      final sessionList = await sessionListNotifier.loadSessions();
      expect(sessionList, isA<AsyncData<List<Session>>>());
      expect(
        sessionList
            .when(
              data: (data) => data,
              loading: () => [],
              error: (error, stackTrace) => [],
            )
            .length,
        1,
      );
    });

    test('Should create a Session', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(
        () => sessionRepository.getAllSessions(),
      ).thenAnswer((_) async => [Session.empty()]);
      when(
        () => sessionRepository.addSession(newSession),
      ).thenAnswer((_) async => newSession);
      final sessionListNotifier = SessionListNotifier(
        sessionRepository: sessionRepository,
      );
      await sessionListNotifier.loadSessions();
      final session = await sessionListNotifier.addSession(newSession);
      expect(session, true);
    });

    test('Should update a Session', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(
        () => sessionRepository.getAllSessions(),
      ).thenAnswer((_) async => [newSession]);
      when(
        () => sessionRepository.updateSession(newSession),
      ).thenAnswer((_) async => true);
      final sessionListNotifier = SessionListNotifier(
        sessionRepository: sessionRepository,
      );
      await sessionListNotifier.loadSessions();
      final session = await sessionListNotifier.updateSession(newSession);
      expect(session, true);
    });

    test('Should delete a Session', () async {
      final sessionRepository = MockSessionRepository();
      final newSession = Session.empty();
      when(
        () => sessionRepository.getAllSessions(),
      ).thenAnswer((_) async => [newSession]);
      when(
        () => sessionRepository.deleteSession(newSession.id),
      ).thenAnswer((_) async => true);
      final sessionListNotifier = SessionListNotifier(
        sessionRepository: sessionRepository,
      );
      await sessionListNotifier.loadSessions();
      final session = await sessionListNotifier.deleteSession(newSession);
      expect(session, true);
    });
  });
}
