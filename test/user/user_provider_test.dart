import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class MockUserRepository extends Mock implements Openapi {}

void main() {
  group('UserNotifier', () {
    late MockUserRepository mockRepository;
    late UserNotifier provider;
    final user = EmptyModels.empty<CoreUser>().copyWith(id: '1');

    setUp(() {
      mockRepository = MockUserRepository();
      provider = UserNotifier(userRepository: mockRepository);
    });

    test('loadUser returns expected data', () async {
      when(() => mockRepository.usersUserIdGet(userId: any(named: 'userId')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          user,
        ),
      );

      final result = await provider.loadUser('1');

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => null,
        ),
        user,
      );
    });

    test('loadUser handles error', () async {
      when(() => mockRepository.usersUserIdGet(userId: any(named: 'userId')))
          .thenThrow(Exception('Failed to load user'));

      final result = await provider.loadUser('1');

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });

    test('loadMe returns expected data', () async {
      when(() => mockRepository.usersMeGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          user,
        ),
      );

      final result = await provider.loadMe();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => null,
        ),
        user,
      );
    });

    test('loadMe handles error', () async {
      when(() => mockRepository.usersMeGet())
          .thenThrow(Exception('Failed to load user'));

      final result = await provider.loadMe();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
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
        (_) async => chopper.Response(
          http.Response('body', 200),
          user,
        ),
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
      when(() => mockRepository.usersMePatch(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          user,
        ),
      );

      provider.state = AsyncValue.data(user);
      final result = await provider.updateMe(user);

      expect(result, true);
    });

    test('updateMe handles error', () async {
      when(() => mockRepository.usersMePatch(body: any(named: 'body')))
          .thenThrow(Exception('Failed to update user'));

      provider.state = AsyncValue.data(user);
      final result = await provider.updateMe(user);

      expect(result, false);
    });

    test('changePassword changes user password', () async {
      when(
        () => mockRepository.usersChangePasswordPost(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      provider.state = AsyncValue.data(user);
      final result =
          await provider.changePassword('oldPassword', 'newPassword', user);

      expect(result, true);
    });

    test('deletePersonal deletes user data', () async {
      when(() => mockRepository.usersMeAskDeletionPost()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      provider.state = AsyncValue.data(user);
      final result = await provider.deletePersonal();

      expect(result, true);
    });

    test('deletePersonal handles error', () async {
      when(() => mockRepository.usersMeAskDeletionPost())
          .thenThrow(Exception('Failed to delete personal data'));

      provider.state = AsyncValue.data(user);
      final result = await provider.deletePersonal();

      expect(result, false);
    });

    test('askMailMigration requests mail migration', () async {
      when(() => mockRepository.usersMigrateMailPost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      provider.state = AsyncValue.data(user);
      final result = await provider.askMailMigration('newmail@example.com');

      expect(result, true);
    });
  });
}
