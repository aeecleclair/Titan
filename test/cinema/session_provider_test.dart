// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/cinema/providers/session_provider.dart';

void main() {
  group('CinemaPageProvider', () {
    test('SessionNotifier initial state is empty', () {
      final sessionNotifier = SessionNotifier();
      expect(sessionNotifier.state.id, Session.empty().id);
    });

    test('SessionNotifier setSession updates state', () {
      final sessionNotifier = SessionNotifier();
      final session = Session.empty().copyWith(id: '1');
      sessionNotifier.setSession(session);
      expect(sessionNotifier.state, session);
    });

    test('sessionProvider returns SessionNotifier state', () {
      final container = ProviderContainer();
      final session = Session.empty().copyWith(id: '1');
      container.read(sessionProvider.notifier).setSession(session);
      final sessionState = container.read(sessionProvider);
      expect(sessionState, session);
    });
  });
}
