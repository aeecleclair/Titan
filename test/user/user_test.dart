import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/super_admin/class/account_type.dart';
import 'package:titan/user/class/applicant.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:titan/user/class/user.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:titan/user/repositories/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('Testing User class', () {
    test('Should return a user', () async {
      final user = User.empty();
      expect(user, isA<User>());
    });

    test('Should return a user with a name', () async {
      final user = User.empty();
      expect(user.name, 'Nom'); // capitaliseAll
    });

    test('Should parse an User from json', () async {
      final birthday = DateTime(1999, 1, 1);
      final createdOn = DateTime.utc(2021, 1, 1);
      final user = User.fromJson({
        "name": "name",
        "firstname": "firstname",
        "nickname": null,
        "id": "id",
        "birthday": "1999-01-01",
        "created_on": createdOn.toIso8601String(),
        "email": "email",
        "account_type": "external",
        "floor": "autre",
        "groups": [],
        "phone": null,
        "promo": null,
      });
      expect(user, isA<User>());
      expect(user.name, 'Name');
      expect(user.firstname, 'Firstname');
      expect(user.nickname, null);
      expect(user.id, 'id');
      expect(user.birthday, birthday);
      expect(user.createdOn, createdOn.toLocal());
      expect(user.email, 'email');
      expect(user.floor, 'autre');
      expect(user.groups, []);
      expect(user.phone, null);
      expect(user.promo, null);
    });

    test('Should parse an User from json with all non-null fields', () async {
      final user = User.fromJson({
        "name": "name",
        "firstname": "firstname",
        "nickname": "nickname",
        "id": "id",
        "birthday": "1999-01-01",
        "created_on": "2021-01-01",
        "email": "email",
        "account_type": "external",
        "floor": "autre",
        "groups": [],
        "phone": "phone",
        "promo": 1,
      });
      expect(user, isA<User>());
      expect(user.name, 'Name');
      expect(user.firstname, 'Firstname');
      expect(user.nickname, 'Nickname');
      expect(user.id, 'id');
      expect(user.birthday, DateTime(1999, 1, 1));
      expect(user.createdOn, DateTime(2021, 1, 1));
      expect(user.email, 'email');
      expect(user.floor, 'autre');
      expect(user.groups, []);
      expect(user.phone, 'phone');
      expect(user.promo, 1);
    });

    test('Should update with new values', () {
      final user = User.empty();
      User newUser = user.copyWith(name: 'name');
      expect(newUser.name, 'name');
      newUser = user.copyWith(firstname: 'firstname');
      expect(newUser.firstname, 'firstname');
      newUser = user.copyWith(nickname: 'nickname');
      expect(newUser.nickname, 'nickname');
      newUser = user.copyWith(id: 'id');
      expect(newUser.id, 'id');
      newUser = user.copyWith(birthday: DateTime(1999, 1, 1));
      expect(newUser.birthday, DateTime(1999, 1, 1));
      newUser = user.copyWith(createdOn: DateTime(2001, 1, 1));
      expect(newUser.createdOn, DateTime(2001, 1, 1));
      newUser = user.copyWith(email: 'email');
      expect(newUser.email, 'email');
      newUser = user.copyWith(floor: 'floor');
      expect(newUser.floor, 'floor');
      newUser = user.copyWith(groups: []);
      expect(newUser.groups, []);
      newUser = user.copyWith(phone: 'phone');
      expect(newUser.phone, 'phone');
      newUser = user.copyWith(promo: 1);
      expect(newUser.promo, 1);
    });

    test('Should print a user', () async {
      final user = User(
        name: 'name',
        firstname: 'firstname',
        nickname: null,
        id: 'id',
        accountType: AccountType(type: 'external'),
        birthday: DateTime(1999, 1, 1),
        createdOn: DateTime(2021, 1, 1),
        email: 'email',
        floor: 'floor',
        groups: [],
        phone: 'phone',
        promo: null,
      );
      expect(
        user.toString(),
        'User {name: name, firstname: firstname, nickname: null, id: id, email: email, accountType: external, birthday: 1999-01-01 00:00:00.000, promo: null, floor: floor, phone: phone, createdOn: 2021-01-01 00:00:00.000, groups: []}',
      );
    });

    test('Should return correct json', () async {
      final createdOn = DateTime.utc(2021, 1, 1);
      final user = User.fromJson({
        "name": "name",
        "firstname": "firstname",
        "nickname": null,
        "id": "id",
        "birthday": "1999-01-01",
        "created_on": createdOn.toIso8601String(),
        "email": "email",
        "account_type": "external",
        "floor": "floor",
        "groups": [],
        "phone": "phone",
        "promo": null,
      });
      expect(user.toJson(), {
        "name": "Name",
        "firstname": "Firstname",
        "nickname": null,
        "id": "id",
        "birthday": "1999-01-01",
        "created_on": createdOn.toIso8601String(),
        "email": "email",
        "account_type": "external",
        "floor": "floor",
        "groups": [],
        "phone": "phone",
        "promo": null,
      });
    });
  });

  group('Testing Applicant class', () {
    test('Should return a applicant', () async {
      final applicant = Applicant.empty();
      expect(applicant, isA<Applicant>());
    });

    test('Should return a applicant with a name', () async {
      final applicant = Applicant.empty();
      expect(applicant.name, 'Nom'); // capitaliseAll
    });

    test('Should update with new values', () async {
      final applicant = Applicant.empty();
      Applicant newApplicant = applicant.copyWith(name: 'name');
      expect(newApplicant.name, 'name');
      newApplicant = applicant.copyWith(firstname: 'firstname');
      expect(newApplicant.firstname, 'firstname');
      newApplicant = applicant.copyWith(nickname: 'nickname');
      expect(newApplicant.nickname, 'nickname');
      newApplicant = applicant.copyWith(id: 'id');
      expect(newApplicant.id, 'id');
    });

    test('Should print properly', () {
      final applicant = Applicant.empty();
      expect(
        applicant.toString(),
        'Applicant{name: Nom, firstname: Prénom, nickname: null, id: , email: empty@ecl.ec-lyon.fr, promo: null, phone: null, accountType: external}',
      );
    });

    test('Should parse an Applicant from json', () async {
      final applicant = Applicant.fromJson({
        "name": "name",
        "firstname": "firstname",
        "nickname": null,
        "id": "id",
        "email": "email",
        "account_type": "external",
        "phone": "phone",
        "promo": null,
      });
      expect(applicant, isA<Applicant>());
    });

    test('Should return correct json', () async {
      final applicant = Applicant.fromJson({
        "name": "name",
        "firstname": "firstname",
        "nickname": null,
        "id": "id",
        "email": "email",
        "account_type": "external",
        "phone": "phone",
        "promo": null,
      });
      expect(applicant.toJson(), {
        "name": "Name",
        "firstname": "Firstname",
        "nickname": null,
        "id": "id",
        "email": "email",
        "account_type": "external",
        "promo": null,
        "phone": "phone",
        "applicant_id": "id",
      });
    });
  });

  group('Testing SimpleUser class', () {
    test('Should return a simpleUser', () async {
      final simpleUser = SimpleUser.empty();
      expect(simpleUser, isA<SimpleUser>());
    });

    test('Should return a simpleUser with a name', () async {
      final simpleUser = SimpleUser.empty();
      expect(simpleUser.name, 'Nom'); // capitaliseAll
    });

    test('Should print properly the name', () {
      final simpleUser = SimpleUser.empty();
      expect(simpleUser.getName(), 'Prénom Nom');
      final simpleUserWithNickName = SimpleUser.empty().copyWith(
        nickname: 'nickname',
      );
      expect(simpleUserWithNickName.getName(), 'nickname (Prénom Nom)');
    });

    test('Should update with new values', () async {
      final simpleUser = SimpleUser.empty();
      SimpleUser newSimpleUser = simpleUser.copyWith(name: 'name');
      expect(newSimpleUser.name, 'name');
      newSimpleUser = simpleUser.copyWith(firstname: 'firstname');
      expect(newSimpleUser.firstname, 'firstname');
      newSimpleUser = simpleUser.copyWith(nickname: 'nickname');
      expect(newSimpleUser.nickname, 'nickname');
      newSimpleUser = simpleUser.copyWith(id: 'id');
      expect(newSimpleUser.id, 'id');
    });

    test('Should print properly', () {
      final simpleUser = SimpleUser.empty();
      expect(
        simpleUser.toString(),
        'SimpleUser {name: Nom, firstname: Prénom, nickname: null, id: , accountType: external}',
      );
    });

    test('Should parse an SimpleUser from json', () async {
      final simpleUser = SimpleUser.fromJson({
        "name": "name",
        "firstname": "firstname",
        "nickname": null,
        "account_type": "external",
        "id": "id",
      });
      expect(simpleUser, isA<SimpleUser>());
    });

    test('Should return correct json', () async {
      final simpleUser = SimpleUser.fromJson({
        "name": "name",
        "firstname": "firstname",
        "nickname": null,
        "account_type": "external",
        "id": "id",
      });
      expect(simpleUser.toJson(), {
        "name": "Name",
        "firstname": "Firstname",
        "nickname": null,
        "account_type": "external",
        "id": "id",
      });
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
        true,
      );
    });

    test('Should fail if user if not loaded', () async {
      final mockUser = MockUserRepository();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      final UserNotifier userNotifier = UserNotifier(userRepository: mockUser);
      expect(
        await userNotifier.setUser(User.empty().copyWith(name: 'New Name')),
        false,
      );
    });
  });

  group('Testing loadMe', () {
    test('Should return a user', () async {
      final mockUser = MockUserRepository();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      final UserNotifier userNotifier = UserNotifier(userRepository: mockUser);
      final user = await userNotifier.loadMe();
      final now = DateTime.now();
      expect(user, isA<AsyncData<User>>());
      expect(
        user.when(
          data: (value) => value.copyWith(createdOn: now).toString(),
          error: (Object error, StackTrace stackTrace) {},
          loading: () {},
        ),
        User.empty().copyWith(createdOn: now).toString(),
      );
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
      when(
        () => mockUser.changePassword('old', 'new', user.email),
      ).thenAnswer((_) async => true);
      final UserNotifier userNotifier = UserNotifier(userRepository: mockUser);
      await userNotifier.loadMe();
      expect(await userNotifier.changePassword('old', 'new', user), true);
    });

    test('Should catch error when changePassword fail', () async {
      final mockUser = MockUserRepository();
      final User user = User.empty();
      when(() => mockUser.getMe()).thenAnswer((_) async => User.empty());
      when(
        () => mockUser.changePassword('old', 'new', user.email),
      ).thenAnswer((_) async => false);
      final UserNotifier userNotifier = UserNotifier(userRepository: mockUser);
      await userNotifier.loadMe();
      expect(await userNotifier.changePassword('old', 'new', user), false);
    });
  });
}
