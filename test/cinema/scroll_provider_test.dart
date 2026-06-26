import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:titan/cinema/providers/scroll_provider.dart';
import 'package:titan/cinema/providers/session_list_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class MockSessionRepository extends Mock implements Openapi {}

void main() {
  group('ScrollNotifier', () {
    late MockSessionRepository mockRepository;
    // Sessions crafted so that the central element index is 2:
    // two past sessions then a future one => indexWhere(...future) == 2.
    final sessions = [
      CineSessionComplete.empty().copyWith(id: '1', start: DateTime(2000)),
      CineSessionComplete.empty().copyWith(id: '2', start: DateTime(2001)),
      CineSessionComplete.empty().copyWith(id: '3', start: DateTime(2100)),
    ];

    ProviderContainer makeContainer() {
      mockRepository = MockSessionRepository();
      when(() => mockRepository.cinemaSessionsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), sessions),
      );
      return ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
    }

    test('setScroll should update state', () async {
      final container = makeContainer();
      addTearDown(container.dispose);
      // Trigger the session load chain and let it settle so that
      // mainPageIndexProvider.startPage resolves before reading scroll.
      container.read(sessionListProvider.notifier);
      await Future(() {});
      final scrollNotifier = container.read(scrollProvider.notifier);
      scrollNotifier.setScroll(100.0);
      expect(scrollNotifier.state, 100.0);
    });

    test('reset should set state to startScroll', () async {
      final container = makeContainer();
      addTearDown(container.dispose);
      // Trigger the session load chain and let it settle so that
      // mainPageIndexProvider.startPage resolves before reading scroll.
      container.read(sessionListProvider.notifier);
      await Future(() {});
      final scrollNotifier = container.read(scrollProvider.notifier);
      scrollNotifier.setScroll(100.0);
      scrollNotifier.reset();
      expect(scrollNotifier.state, 2.0);
    });
  });
}
