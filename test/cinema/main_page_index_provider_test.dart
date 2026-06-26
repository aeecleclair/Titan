import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:titan/cinema/providers/main_page_index_provider.dart';
import 'package:titan/cinema/providers/session_list_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class MockSessionRepository extends Mock implements Openapi {}

void main() {
  group('MainPageIndexNotifier', () {
    late MockSessionRepository mockRepository;
    // Sessions crafted so that the central element index is 2:
    // two past sessions then a future one => indexWhere(...future) == 2.
    final sessions = [
      CineSessionComplete.empty().copyWith(id: '1', start: DateTime(2000)),
      CineSessionComplete.empty().copyWith(id: '2', start: DateTime(2001)),
      CineSessionComplete.empty().copyWith(id: '3', start: DateTime(2100)),
    ];

    Future<MainPageIndexNotifier> makeNotifier(
      ProviderContainer container,
    ) async {
      container.read(sessionListProvider.notifier);
      await Future(() {});
      return container.read(mainPageIndexProvider.notifier);
    }

    ProviderContainer makeContainer() {
      mockRepository = MockSessionRepository();
      when(() => mockRepository.cinemaSessionsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), sessions),
      );
      return ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
    }

    test('MainPageIndexNotifier sets correct initial state', () async {
      final container = makeContainer();
      addTearDown(container.dispose);
      final notifier = await makeNotifier(container);
      expect(notifier.state, 2);
    });

    test('MainPageIndexNotifier setMainPageIndex updates state', () async {
      final container = makeContainer();
      addTearDown(container.dispose);
      final notifier = await makeNotifier(container);
      notifier.setMainPageIndex(4);
      expect(notifier.state, 4);
    });

    test('MainPageIndexNotifier setStartPage updates startpage', () async {
      final container = makeContainer();
      addTearDown(container.dispose);
      final notifier = await makeNotifier(container);
      notifier.setStartPage(3);
      expect(notifier.startPage, 3);
    });

    test('MainPageIndexNotifier reset sets state to startpage', () async {
      final container = makeContainer();
      addTearDown(container.dispose);
      final notifier = await makeNotifier(container);
      notifier.setMainPageIndex(4);
      notifier.setStartPage(3);
      notifier.reset();
      expect(notifier.state, 3);
    });
  });
}
