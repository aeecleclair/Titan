import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:myecl/amap/providers/cash_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class MockCashRepository extends Mock implements Openapi {}

void main() {
  group('CashListProvider', () {
    final cash1 = CashComplete(
      balance: 100.0,
      userId: '1',
      user: CoreUserSimple(
        id: '1',
        name: 'John',
        firstname: 'Doe',
        nickname: null,
        accountType: AccountType.$external,
        schoolId: 'schoolId',
      ),
    );
    final cash2 = CashComplete(
      balance: 200.0,
      userId: '2',
      user: CoreUserSimple(
        id: '2',
        name: 'Jane',
        firstname: 'Doe',
        nickname: null,
        accountType: AccountType.$external,
        schoolId: 'schoolId',
      ),
    );

    test('Should load cash list', () async {
      final mockCashRepository = MockCashRepository();
      when(() => mockCashRepository.amapUsersCashGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), [cash1]),
      );
      final CashListProvider cashListProvider =
          CashListProvider(cashRepository: mockCashRepository);
      final result = await cashListProvider.loadCashList();
      expect(result, isA<AsyncData<List<CashComplete>>>());
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
      final mockCashRepository = MockCashRepository();
      when(() => mockCashRepository.amapUsersCashGet())
          .thenThrow(Exception('Error'));
      final CashListProvider cashListProvider =
          CashListProvider(cashRepository: mockCashRepository);
      final result = await cashListProvider.loadCashList();
      expect(result, isA<AsyncError>());
    });

    test('Should add cash', () async {
      final mockCashRepository = MockCashRepository();
      when(
        () => mockCashRepository.amapUsersUserIdCashPost(
          userId: any(named: 'userId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), cash1),
      );
      final CashListProvider cashListProvider =
          CashListProvider(cashRepository: mockCashRepository);
      cashListProvider.state = AsyncData([]);
      final result = await cashListProvider.addCash(cash1);
      expect(result, true);
    });

    test('Should handle error when adding cash', () async {
      final mockCashRepository = MockCashRepository();
      when(
        () => mockCashRepository.amapUsersUserIdCashPost(
          userId: any(named: 'userId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Error'));
      final CashListProvider cashListProvider =
          CashListProvider(cashRepository: mockCashRepository);
      cashListProvider.state = AsyncData([]);
      final result = await cashListProvider.addCash(cash1);
      expect(result, false);
    });

    test('Should update cash', () async {
      final mockCashRepository = MockCashRepository();
      when(
        () => mockCashRepository.amapUsersUserIdCashPatch(
          userId: any(named: 'userId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          cash1.copyWith(balance: 50.0),
        ),
      );
      final CashListProvider cashListProvider =
          CashListProvider(cashRepository: mockCashRepository);
      cashListProvider.state = AsyncData([cash1]);
      final result = await cashListProvider.updateCash(cash1, 50.0);
      expect(result, true);
    });

    test('Should handle error when updating cash', () async {
      final mockCashRepository = MockCashRepository();
      when(
        () => mockCashRepository.amapUsersUserIdCashPatch(
          userId: any(named: 'userId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Error'));
      final CashListProvider cashListProvider =
          CashListProvider(cashRepository: mockCashRepository);
      cashListProvider.state = AsyncData([cash1]);
      final result = await cashListProvider.updateCash(cash1, 50.0);
      expect(result, false);
    });

    test('Should filter cash list', () async {
      final mockCashRepository = MockCashRepository();
      when(() => mockCashRepository.amapUsersCashGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), [cash1, cash2]),
      );
      final CashListProvider cashListProvider =
          CashListProvider(cashRepository: mockCashRepository);
      await cashListProvider.loadCashList();
      final result = await cashListProvider.filterCashList('Jane');
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
      final mockCashRepository = MockCashRepository();
      when(() => mockCashRepository.amapUsersCashGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), [cash1]),
      );
      final CashListProvider cashListProvider =
          CashListProvider(cashRepository: mockCashRepository);
      await cashListProvider.loadCashList();
      await cashListProvider.refreshCashList();
      expect(
        cashListProvider.state.when(
          data: (data) => data,
          error: (e, s) => null,
          loading: () => null,
        ),
        [cash1],
      );
    });
  });
}
