import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:myecl/amap/providers/user_amount_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class MockAmapUserRepository extends Mock implements Openapi {}

void main() {
  late MockAmapUserRepository mockRepository;
  late UserCashNotifier notifier;

  final user = CoreUserSimple(
    id: '123',
    name: 'name',
    firstname: 'firstname',
    nickname: null,
    accountType: AccountType.$external,
    schoolId: 'schoolId',
  );
  final cash = CashComplete(
    balance: 100.0,
    userId: '123',
    user: user,
  );

  setUp(() {
    mockRepository = MockAmapUserRepository();
    notifier = UserCashNotifier(amapUserRepository: mockRepository);
  });

  group('loadCashByUser', () {
    test('returns cash for valid user id', () async {
      when(() => mockRepository.amapUsersUserIdCashGet(userId: '123'))
          .thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), cash),
      );

      final result = await notifier.loadCashByUser(user.id);

      expect(
        result.when(
          data: (value) => value.balance,
          loading: () => 0.0,
          error: (error, stackTrace) => 0.0,
        ),
        equals(100.0),
      );
      verify(() => mockRepository.amapUsersUserIdCashGet(userId: '123'))
          .called(1);
    });

    test('returns error for invalid user id', () async {
      const error = 'User not found';
      when(() => mockRepository.amapUsersUserIdCashGet(userId: '123'))
          .thenThrow(Exception(error));

      final result = await notifier.loadCashByUser('123');

      expect(result, isA<AsyncError>());
      verify(() => mockRepository.amapUsersUserIdCashGet(userId: '123'))
          .called(1);
    });
  });

  group('updateCash', () {
    test('updates cash balance', () async {
      notifier.state = AsyncValue.data(cash);

      await notifier.updateCash(50.0);

      expect(
        notifier.state.when(
          data: (value) => value.balance,
          loading: () => 0.0,
          error: (error, stackTrace) => 0.0,
        ),
        equals(150.0),
      );
    });

    test('returns error when loading', () async {
      notifier.state = const AsyncValue.loading();

      await notifier.updateCash(50.0);

      expect(
        notifier.state,
        const AsyncValue<CashComplete>.error(
          "Cannot update cash while loading",
          StackTrace.empty,
        ),
      );
    });

    test('returns error when error', () async {
      const error = 'User not found';
      notifier.state = const AsyncValue.error(error, StackTrace.empty);

      await notifier.updateCash(50.0);

      expect(notifier.state.error, equals(error));
    });
  });
}
