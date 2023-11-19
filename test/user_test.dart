import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/user/class/applicant.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/user/repositories/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('Testing User Class', () {
    test('Should return a user', () async {
      final mockUser = MockUserRepository();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      final user = await mockUser.getMe();
      expect(user, isA<User>());
    });

    test('Should return a user with a name', () async {
      final mockUser = MockUserRepository();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      final user = await mockUser.getMe();
      expect(user.name, 'Nom');
    });

    test('Should parse an User from json', () async {
      final mockUser = MockUserRepository();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.fromJson({
            "birthday": "1999-01-01",
            "created_on": "2021-01-01",
            "email": "email",
            "firstname": "firstname",
            "floor": "floor",
            "groups": [],
            "id": "id",
            "name": "name",
            "nickname": "nickname",
            "phone": "phone",
            "promo": null
          }));
      final user = await mockUser.getMe();
      expect(user.name, 'Name'); // capitaliseAll
    });

    test('Should return correct json', () async {
      final mockUser = MockUserRepository();
      when(() => mockUser.getMe()).thenAnswer((_) async => User(
          birthday: '1999-01-01',
          createdOn: '2021-01-01',
          email: 'email',
          firstname: 'firstname',
          floor: 'floor',
          groups: [],
          id: 'id',
          name: 'name',
          nickname: 'nickname',
          phone: 'phone',
          promo: null));
      final user = await mockUser.getMe();
      expect(user.toJson(), {
        "birthday": "1999-01-01",
        "created_on": "2021-01-01",
        "email": "email",
        "firstname": "firstname",
        "floor": "floor",
        "groups": [],
        "id": "id",
        "name": "name",
        "nickname": "nickname",
        "phone": "phone",
        "promo": null
      });
    });

    test('Should change user name', () async {
      final mockUser = MockUserRepository();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      final user = await mockUser.getMe();
      final newUser = user.copyWith(name: 'New Name');
      expect(newUser.name, 'New Name');
    });
  });

  group('Testing User conversion', () {
    test('Should convert user to SimpleUser', () async {
      final mockUser = MockUserRepository();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      final user = await mockUser.getMe();
      expect(user.toSimpleUser(), isA<SimpleUser>());
    });

    test('Should convert user to Applicant', () async {
      final mockUser = MockUserRepository();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      final user = await mockUser.getMe();
      expect(user.toApplicant(), isA<Applicant>());
    });
  });

  group('Testing setUser', () {
    test('Should set new user', () async {
      final mockUser = MockUserRepository();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      final UserNotifier userNotifier = UserNotifier(userRepository: mockUser);
      await userNotifier.loadMe();
      expect(
          await userNotifier.setUser(User.empty().copyWith(name: 'New Name')),
          true);
    });

    test('Should fail if user if not loaded', () async {
      final mockUser = MockUserRepository();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      final UserNotifier userNotifier = UserNotifier(userRepository: mockUser);
      expect(
          await userNotifier.setUser(User.empty().copyWith(name: 'New Name')),
          false);
    });
  });

  group('Testing loadMe', () {
    test('Should return a user', () async {
      final mockUser = MockUserRepository();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      final UserNotifier userNotifier = UserNotifier(userRepository: mockUser);
      final user = await userNotifier.loadMe();
      expect(user, isA<AsyncData<User>>());
      expect(
          user.when(
              data: (value) => value.toString(),
              error: (Object error, StackTrace stackTrace) {},
              loading: () {}),
          User.empty().toString());
    });

    test('Should catch error when getMe fail', () async {
      final mockUser = MockUserRepository();
      when(() => mockUser.getMe()).thenThrow(Exception('Error'));
      final UserNotifier userNotifier = UserNotifier(userRepository: mockUser);
      expect(await userNotifier.loadMe(), isA<AsyncError>());
    });
  });

  group('Testing UpdateMe', () {
    test('Should update user', () async {
      final mockUser = MockUserRepository();
      final newUser = User.empty().copyWith(name: 'New Name');
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      when(() => mockUser.updateMe(newUser)).thenAnswer((_) async => true);
      final UserNotifier userNotifier = UserNotifier(userRepository: mockUser);
      await userNotifier.loadMe();
      expect(await userNotifier.updateMe(newUser), true);
    });

    test('Should catch error when updateMe fail', () async {
      final mockUser = MockUserRepository();
      final newUser = User.empty().copyWith(name: 'New Name');
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      when(() => mockUser.updateMe(newUser)).thenThrow(Exception('Error'));
      final UserNotifier userNotifier = UserNotifier(userRepository: mockUser);
      await userNotifier.loadMe();
      expect(await userNotifier.updateMe(newUser), false);
    });

    test('Should catch error if user is not loaded', () async {
      final mockUser = MockUserRepository();
      final newUser = User.empty().copyWith(name: 'New Name');
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      when(() => mockUser.updateMe(newUser)).thenAnswer((_) async => true);
      final UserNotifier userNotifier = UserNotifier(userRepository: mockUser);
      expect(await userNotifier.updateMe(newUser), false);
    });
  });

  group('Testing changePassword', () {
    test('Should change password', () async {
      final mockUser = MockUserRepository();
      final User user = User.empty();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      when(() => mockUser.changePassword('old', 'new', user.email))
          .thenAnswer((_) async => true);
      final UserNotifier userNotifier = UserNotifier(userRepository: mockUser);
      await userNotifier.loadMe();
      expect(await userNotifier.changePassword('old', 'new', user), true);
    });

    test('Should catch error when changePassword fail', () async {
      final mockUser = MockUserRepository();
      final User user = User.empty();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      when(() => mockUser.changePassword('old', 'new', user.email))
          .thenAnswer((_) async => false);
      final UserNotifier userNotifier = UserNotifier(userRepository: mockUser);
      await userNotifier.loadMe();
      expect(await userNotifier.changePassword('old', 'new', user), false);
    });
  });
}
