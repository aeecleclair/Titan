import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/cinema/providers/session_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

void main() {
  group('SessionNotifier', () {
    late ProviderContainer container;
    late SessionNotifier notifier;
    final session = CineSessionComplete(
      id: '1',
      name: 'Test Session',
      start: DateTime.now(),
      duration: 120,
      overview: 'Overview',
      genre: 'Genre',
      tagline: 'Tagline',
    );

    setUp(() {
      container = ProviderContainer();
      notifier = container.read(sessionProvider.notifier);
    });

    test('setSession should update state', () {
      notifier.setSession(session);

      expect(container.read(sessionProvider).id, equals('1'));
      expect(container.read(sessionProvider).name, equals('Test Session'));
      expect(container.read(sessionProvider).duration, equals(120));
    });

    test('resetSession should reset state', () {
      notifier.setSession(session);
      notifier.setSession(CineSessionComplete.fromJson({}));

      expect(container.read(sessionProvider).id, equals(''));
      expect(container.read(sessionProvider).name, equals(''));
      expect(container.read(sessionProvider).duration, equals(0));
    });
  });
}
