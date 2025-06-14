import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:titan/amap/class/cash.dart';
import 'package:titan/amap/providers/cash_list_provider.dart';
import 'package:titan/amap/repositories/cash_repository.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/user/class/simple_users.dart';

class MockCashRepository extends Mock implements CashRepository {}

void main() {
  group('CashProvider', () {
    test(
      'loadCashList should update state with cash list from repository',
      () async {
        final mockRepository = MockCashRepository();
        final cashProvider = CashListProvider(cashRepository: mockRepository);

        when(
          () => mockRepository.getCashList(),
        ).thenAnswer((_) async => [Cash.empty().copyWith(balance: 100)]);

        final result = await cashProvider.loadCashList();

        expect(result, isA<AsyncData<List<Cash>>>());
        expect(
          result
              .when(
                data: (cashList) => cashList,
                loading: () => [],
                error: (error, stackTrace) => [],
              )
              .first
              .balance,
          100,
        );
        expect(cashProvider.state, result);
      },
    );

    test('addCash should add cash to repository and update state', () async {
      final mockRepository = MockCashRepository();
      final cashProvider = CashListProvider(cashRepository: mockRepository);
      final cash = Cash.empty().copyWith(balance: 100);
      cashProvider.state = AsyncData([cash]);

      when(() => mockRepository.createCash(cash)).thenAnswer((_) async => cash);

      final result = await cashProvider.addCash(cash);

      expect(result, true);
      expect(cashProvider.state, isA<AsyncData<List<Cash>>>());
      expect(
        cashProvider.state
            .when(
              data: (cashList) => cashList,
              loading: () => [],
              error: (error, stackTrace) => [],
            )
            .first,
        cash,
      );
    });

    test(
      'updateCash should update cash in repository and update state',
      () async {
        final mockRepository = MockCashRepository();
        final cashProvider = CashListProvider(cashRepository: mockRepository);
        final cash = Cash.empty().copyWith(balance: 100);
        cashProvider.state = AsyncData([cash]);

        when(
          () => mockRepository.updateCash(cash),
        ).thenAnswer((_) async => true);

        final result = await cashProvider.updateCash(cash, 50);

        expect(result, true);
        expect(cashProvider.state, isA<AsyncData<List<Cash>>>());
        expect(
          cashProvider.state
              .when(
                data: (cashList) => cashList,
                loading: () => [],
                error: (error, stackTrace) => [],
              )
              .first
              .balance,
          150,
        );
      },
    );

    test('fakeUpdateCash should update cash in state only', () async {
      final mockRepository = MockCashRepository();
      final cashProvider = CashListProvider(cashRepository: mockRepository);
      final cash = Cash.empty().copyWith(balance: 100);
      cashProvider.state = AsyncData([cash]);

      final result = await cashProvider.fakeUpdateCash(
        cash.copyWith(balance: 50),
      );

      expect(result, true);
      expect(cashProvider.state, isA<AsyncData<List<Cash>>>());
      expect(
        cashProvider.state
            .when(
              data: (cashList) => cashList,
              loading: () => [],
              error: (error, stackTrace) => [],
            )
            .first
            .balance,
        50,
      );
    });

    test(
      'filterCashList should filter cash list by name, firstname, and nickname',
      () async {
        final mockRepository = MockCashRepository();
        final cashProvider = CashListProvider(cashRepository: mockRepository);
        final cashList = [
          Cash.empty().copyWith(
            user: SimpleUser.empty().copyWith(
              name: 'John',
              firstname: 'Doe',
              nickname: 'JD',
            ),
            balance: 100,
          ),
          Cash.empty().copyWith(
            user: SimpleUser.empty().copyWith(
              name: 'Jane',
              firstname: 'Doe',
              nickname: 'JD',
            ),
            balance: 200,
          ),
          Cash.empty().copyWith(
            user: SimpleUser.empty().copyWith(
              name: 'Bob',
              firstname: 'Smith',
              nickname: null,
            ),
            balance: 300,
          ),
        ];

        when(
          () => mockRepository.getCashList(),
        ).thenAnswer((_) async => cashList);
        await cashProvider.loadCashList();

        final result1 = await cashProvider.filterCashList('j');
        cashProvider.state = AsyncData(cashList);
        final result2 = await cashProvider.filterCashList('doe');
        cashProvider.state = AsyncData(cashList);
        final result3 = await cashProvider.filterCashList('jd');
        cashProvider.state = AsyncData(cashList);
        final result4 = await cashProvider.filterCashList('smith');
        cashProvider.state = AsyncData(cashList);
        final result5 = await cashProvider.filterCashList('foo');

        expect(
          result1
              .when(
                data: (cashList) => cashList,
                loading: () => [],
                error: (error, stackTrace) => [],
              )
              .length,
          2,
        );
        expect(
          result2
              .when(
                data: (cashList) => cashList,
                loading: () => [],
                error: (error, stackTrace) => [],
              )
              .length,
          2,
        );
        expect(
          result3
              .when(
                data: (cashList) => cashList,
                loading: () => [],
                error: (error, stackTrace) => [],
              )
              .length,
          2,
        );
        expect(
          result4
              .when(
                data: (cashList) => cashList,
                loading: () => [],
                error: (error, stackTrace) => [],
              )
              .length,
          1,
        );
        expect(
          result5
              .when(
                data: (cashList) => cashList,
                loading: () => [],
                error: (error, stackTrace) => [],
              )
              .length,
          0,
        );
      },
    );

    test(
      'filterCash List should return current state if error is not tokenExpire',
      () async {
        final mockRepository = MockCashRepository();
        final cashProvider = CashListProvider(cashRepository: mockRepository);

        cashProvider.state = AsyncError(
          AppException(ErrorType.notFound, "test"),
          StackTrace.empty,
        );

        final result = await cashProvider.filterCashList('j');

        expect(result, cashProvider.state);
      },
    );

    test('filterCash should return current state if loading', () async {
      final mockRepository = MockCashRepository();
      final cashProvider = CashListProvider(cashRepository: mockRepository);

      cashProvider.state = const AsyncLoading();

      final result = await cashProvider.filterCashList('j');

      expect(result, cashProvider.state);
    });

    test('refreshCashList should update state with cached cash list', () async {
      final mockRepository = MockCashRepository();
      final cashProvider = CashListProvider(cashRepository: mockRepository);
      final cashList = [Cash.empty().copyWith(balance: 100)];

      when(
        () => mockRepository.getCashList(),
      ).thenAnswer((_) async => cashList);

      final result = await cashProvider.loadCashList();
      final result4 = await cashProvider.filterCashList('smith');
      await cashProvider.refreshCashList();

      expect(
        result
            .when(
              data: (cashList) => cashList,
              loading: () => [],
              error: (error, stackTrace) => [],
            )
            .length,
        1,
      );
      expect(
        result4
            .when(
              data: (cashList) => cashList,
              loading: () => [],
              error: (error, stackTrace) => [],
            )
            .length,
        0,
      );

      expect(cashProvider.state, AsyncData(cashList));
    });
  });
}
