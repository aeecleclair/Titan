import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/amap/providers/user_amount_provider.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:titan/amap/class/cash.dart';
import 'package:titan/amap/repositories/amap_user_repository.dart';

class MockAmapUserRepository extends Mock implements AmapUserRepository {}

void main() {
  late MockAmapUserRepository mockRepository;
  late UserCashNotifier notifier;

  setUp(() {
    mockRepository = MockAmapUserRepository();
    notifier = UserCashNotifier(amapUserRepository: mockRepository);
  });

  group('loadCashByUser', () {
    test('returns cash for valid user id', () async {
      final user = SimpleUser.empty().copyWith(id: '123');
      final cash = Cash(
        balance: 100,
        user: user,
        lastOrderDate: DateTime(2025),
      );
      when(
        () => mockRepository.getCashByUser('123'),
      ).thenAnswer((_) async => cash);

      final result = await notifier.loadCashByUser(user.id);

      expect(
        result.when(
          data: (value) => value.balance,
          loading: () => 0.0,
          error: (error, stackTrace) => 0.0,
        ),
        equals(100.0),
      );
      verify(() => mockRepository.getCashByUser('123')).called(1);
    });

    test('returns error for invalid user id', () async {
      const error = 'User not found';
      when(() => mockRepository.getCashByUser('123')).thenThrow(error);

      final result = await notifier.loadCashByUser('123');

      expect(result.error, equals(error));
      verify(() => mockRepository.getCashByUser('123')).called(1);
    });
  });

  group('updateCash', () {
    test('updates cash balance', () async {
      final cash = Cash(
        balance: 100,
        user: SimpleUser.empty(),
        lastOrderDate: DateTime(2025),
      );
      notifier.state = AsyncValue.data(cash);

      await notifier.updateCash(50);

      expect(
        notifier.state.when(
          data: (value) => value.balance,
          loading: () => 0.0,
          error: (error, stackTrace) => 0.0,
        ),
        equals(150),
      );
    });

    test('returns error when loading', () async {
      notifier.state = const AsyncValue.loading();

      await notifier.updateCash(50);

      expect(
        notifier.state,
        const AsyncValue<Cash>.error(
          "Cannot update cash while loading",
          StackTrace.empty,
        ),
      );
    });

    test('returns error when error', () async {
      const error = 'User not found';
      notifier.state = const AsyncValue.error(error, StackTrace.empty);

      await notifier.updateCash(50);

      expect(notifier.state.error, equals(error));
    });
  });
}
