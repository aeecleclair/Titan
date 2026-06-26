import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:titan/amap/providers/cash_list_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class MockCashRepository extends Mock implements Openapi {}

void main() {
  group('CashListProvider', () {
    late MockCashRepository mockCashRepository;
    late ProviderContainer container;
    late CashListProvider notifier;
    final cash1 = AppModulesAmapSchemasAmapCashComplete(
      balance: 100,
      userId: '1',
      user: CoreUserSimple(
        id: '1',
        name: 'John',
        firstname: 'Doe',
        nickname: null,
        accountType: AccountType.$external,
        schoolId: 'schoolId',
      ),
      lastOrderDate: DateTime(2024),
    );
    final cash2 = AppModulesAmapSchemasAmapCashComplete(
      balance: 200,
      userId: '2',
      user: CoreUserSimple(
        id: '2',
        name: 'Jane',
        firstname: 'Doe',
        nickname: null,
        accountType: AccountType.$external,
        schoolId: 'schoolId',
      ),
      lastOrderDate: DateTime(2024),
    );

    setUp(() async {
      mockCashRepository = MockCashRepository();
      when(() => mockCashRepository.amapUsersCashGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          <AppModulesAmapSchemasAmapCashComplete>[],
        ),
      );
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockCashRepository)],
      );
      notifier = container.read(cashListProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('Should load cash list', () async {
      when(() => mockCashRepository.amapUsersCashGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), [cash1]),
      );
      final result = await notifier.loadCashList();
      expect(
        result,
        isA<AsyncData<List<AppModulesAmapSchemasAmapCashComplete>>>(),
      );
      expect(
        result.when(
          data: (data) => data,
          error: (e, s) => null,
          loading: () => null,
        ),
        [cash1],
      );
    });

    test('Should handle error when loading cash list', () async {
      when(
        () => mockCashRepository.amapUsersCashGet(),
      ).thenThrow(Exception('Error'));
      final result = await notifier.loadCashList();
      expect(result, isA<AsyncError>());
    });

    test('Should add cash', () async {
      when(
        () => mockCashRepository.amapUsersUserIdCashPost(
          userId: any(named: 'userId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), cash1),
      );
      notifier.state = AsyncData([]);
      final result = await notifier.addCash(cash1);
      expect(result, true);
    });

    test('Should handle error when adding cash', () async {
      when(
        () => mockCashRepository.amapUsersUserIdCashPost(
          userId: any(named: 'userId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Error'));
      notifier.state = AsyncData([]);
      final result = await notifier.addCash(cash1);
      expect(result, false);
    });

    test('Should update cash', () async {
      when(
        () => mockCashRepository.amapUsersUserIdCashPatch(
          userId: any(named: 'userId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          cash1.copyWith(balance: 50),
        ),
      );
      notifier.state = AsyncData([cash1]);
      final result = await notifier.updateCash(cash1, 50.0);
      expect(result, true);
    });

    test('Should handle error when updating cash', () async {
      when(
        () => mockCashRepository.amapUsersUserIdCashPatch(
          userId: any(named: 'userId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Error'));
      notifier.state = AsyncData([cash1]);
      final result = await notifier.updateCash(cash1, 50.0);
      expect(result, false);
    });

    test('Should filter cash list', () async {
      when(() => mockCashRepository.amapUsersCashGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), [cash1, cash2]),
      );
      await notifier.loadCashList();
      final result = await notifier.filterCashList('Jane');
      expect(
        result.when(
          data: (data) => data,
          error: (e, s) => null,
          loading: () => null,
        ),
        [cash2],
      );
    });

    test('Should refresh cash list', () async {
      when(() => mockCashRepository.amapUsersCashGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), [cash1]),
      );
      await notifier.loadCashList();
      await notifier.refreshCashList();
      expect(
        notifier.state.when(
          data: (data) => data,
          error: (e, s) => null,
          loading: () => null,
        ),
        [cash1],
      );
    });
  });
}
