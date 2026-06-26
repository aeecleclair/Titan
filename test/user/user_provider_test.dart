import 'dart:async';

import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/user/providers/user_provider.dart';

class MockUserRepository extends Mock implements Openapi {}

class _FalseNotifier extends IsLoggedInProvider {
  @override
  bool build() => false;
}

void main() {
  group('UserNotifier', () {
    late MockUserRepository mockRepository;
    late ProviderContainer container;
    late UserNotifier provider;
    final user = CoreUser.empty().copyWith(id: '1');

    setUp(() async {
      mockRepository = MockUserRepository();
      container = ProviderContainer(
        overrides: [
          repositoryProvider.overrideWithValue(mockRepository),
          // Keep build()'s watched providers stable so the notifier never
          // rebuilds after setUp (a rebuild detaches `provider`'s state setter).
          isLoggedInProvider.overrideWith(() => _FalseNotifier()),
          tokenProvider.overrideWithValue(''),
          idProvider.overrideWith((ref) => Completer<String>().future),
        ],
      );
      provider = container.read(asyncUserProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('loadUser returns expected data', () async {
      when(
        () => mockRepository.usersUserIdGet(userId: any(named: 'userId')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), user),
      );

      final result = await provider.loadUser('1');

      expect(result.maybeWhen(data: (data) => data, orElse: () => null), user);
    });

    test('loadUser handles error', () async {
      when(
        () => mockRepository.usersUserIdGet(userId: any(named: 'userId')),
      ).thenThrow(Exception('Failed to load user'));

      final result = await provider.loadUser('1');

      expect(
        result.maybeWhen(error: (error, _) => error, orElse: () => null),
        isA<Exception>(),
      );
    });

    test('loadMe returns expected data', () async {
      when(() => mockRepository.usersMeGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), user),
      );

      final result = await provider.loadMe();

      expect(result.maybeWhen(data: (data) => data, orElse: () => null), user);
    });

    test('loadMe handles error', () async {
      when(
        () => mockRepository.usersMeGet(),
      ).thenThrow(Exception('Failed to load user'));

      final result = await provider.loadMe();

      expect(
        result.maybeWhen(error: (error, _) => error, orElse: () => null),
        isA<Exception>(),
      );
    });

    test('updateUser updates user data', () async {
      when(
        () => mockRepository.usersUserIdPatch(
          userId: any(named: 'userId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), user),
      );

      provider.state = AsyncValue.data(user);
      final result = await provider.updateUser(user);

      expect(result, true);
    });

    test('updateUser handles error', () async {
      when(
        () => mockRepository.usersUserIdPatch(
          userId: any(named: 'userId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update user'));

      provider.state = AsyncValue.data(user);
      final result = await provider.updateUser(user);

      expect(result, false);
    });

    test('updateMe updates user data', () async {
      when(
        () => mockRepository.usersMePatch(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), user),
      );

      provider.state = AsyncValue.data(user);
      final result = await provider.updateMe(user);

      expect(result, true);
    });

    test('updateMe handles error', () async {
      when(
        () => mockRepository.usersMePatch(body: any(named: 'body')),
      ).thenThrow(Exception('Failed to update user'));

      provider.state = AsyncValue.data(user);
      final result = await provider.updateMe(user);

      expect(result, false);
    });

    test('changePassword changes user password', () async {
      when(
        () => mockRepository.usersChangePasswordPost(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), null),
      );

      provider.state = AsyncValue.data(user);
      final result = await provider.changePassword(
        'oldPassword',
        'newPassword',
        user,
      );

      expect(result, true);
    });

    test('changePassword handles error', () async {
      when(
        () => mockRepository.usersChangePasswordPost(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('error', 400), null),
      );

      final result = await provider.changePassword(
        'oldPassword',
        'newPassword',
        user,
      );

      expect(result, false);
    });

    test('deletePersonal deletes user data', () async {
      when(() => mockRepository.usersMeAskDeletionPost()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), null),
      );

      provider.state = AsyncValue.data(user);
      final result = await provider.deletePersonal();

      expect(result, true);
    });

    test('deletePersonal handles error', () async {
      when(
        () => mockRepository.usersMeAskDeletionPost(),
      ).thenThrow(Exception('Failed to delete personal data'));

      provider.state = AsyncValue.data(user);
      final result = await provider.deletePersonal();

      expect(result, false);
    });

    test('askMailMigration requests mail migration', () async {
      when(
        () => mockRepository.usersMigrateMailPost(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), null),
      );

      provider.state = AsyncValue.data(user);
      final result = await provider.askMailMigration('newmail@example.com');

      expect(result, true);
    });

    test('askMailMigration handles error', () async {
      when(
        () => mockRepository.usersMigrateMailPost(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('error', 400), null),
      );

      final result = await provider.askMailMigration('newmail@example.com');

      expect(result, false);
    });
  });
}
