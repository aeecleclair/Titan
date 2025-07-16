import 'package:flutter_test/flutter_test.dart';
import 'package:titan/login/class/account_type.dart';
import 'package:titan/login/class/create_account.dart';
import 'package:titan/login/class/recover_request.dart';
import 'package:titan/login/tools/functions.dart';

void main() {
  group('Testing RecoverRequest class', () {
    test('Should return an empty RecoverResquest', () {
      final recoverRequest = RecoverRequest.empty();
      expect(recoverRequest, isA<RecoverRequest>());
      expect(recoverRequest.resetToken, '');
      expect(recoverRequest.newPassword, '');
    });

    test('Should return a RecoverRequest', () {
      final recoverRequest = RecoverRequest(
        resetToken: 'token',
        newPassword: 'password',
      );
      expect(recoverRequest, isA<RecoverRequest>());
      expect(recoverRequest.resetToken, 'token');
      expect(recoverRequest.newPassword, 'password');
    });

    test('Should update with new values', () {
      final recoverRequest = RecoverRequest(
        resetToken: 'token',
        newPassword: 'password',
      );
      RecoverRequest newRecoverRequest = recoverRequest.copyWith(
        resetToken: 'newToken',
      );
      expect(newRecoverRequest.resetToken, 'newToken');
      newRecoverRequest = recoverRequest.copyWith(newPassword: 'newPassword');
      expect(newRecoverRequest.newPassword, 'newPassword');
    });

    test('Should print a recoverRequest', () {
      final recoverRequest = RecoverRequest(
        resetToken: 'token',
        newPassword: 'password',
      );
      expect(
        recoverRequest.toString(),
        'RecoverRequest{resetToken: token, newPassword: password}',
      );
    });

    test('Should parse a recoverRequest', () {
      final recoverRequest = RecoverRequest.fromJson({
        "reset_token": "token",
        "new_password": "password",
      });
      expect(recoverRequest, isA<RecoverRequest>());
      expect(recoverRequest.resetToken, 'token');
      expect(recoverRequest.newPassword, 'password');
    });

    test('Should return a correct json', () {
      final recoverRequest = RecoverRequest.fromJson({
        "reset_token": "token",
        "new_password": "password",
      });
      expect(recoverRequest.toJson(), {
        "reset_token": "token",
        "new_password": "password",
      });
    });
  });

  group('Testing CreateAccount class', () {
    test('Should return an empty CreateAccount', () {
      final createAccount = CreateAccount.empty();
      expect(createAccount, isA<CreateAccount>());
      expect(createAccount.password, '');
      expect(createAccount.phone, '');
      expect(createAccount.activationToken, '');
      expect(createAccount.birthday, isA<DateTime>());
      expect(createAccount.firstname, '');
      expect(createAccount.floor, '');
      expect(createAccount.name, '');
      expect(createAccount.nickname, '');
    });

    test('Should return a CreateAccount', () {
      final createAccount = CreateAccount(
        password: 'password',
        phone: 'phone',
        activationToken: '',
        birthday: DateTime.parse('2021-01-01'),
        firstname: '',
        floor: '',
        name: '',
        nickname: '',
        promo: 1,
      );
      expect(createAccount, isA<CreateAccount>());
      expect(createAccount.password, 'password');
      expect(createAccount.phone, 'phone');
      expect(createAccount.activationToken, '');
      expect(createAccount.birthday, DateTime.parse('2021-01-01'));
      expect(createAccount.firstname, '');
      expect(createAccount.floor, '');
      expect(createAccount.name, '');
      expect(createAccount.nickname, '');
      expect(createAccount.promo, 1);
    });

    test('Should update with new values', () {
      final createAccount = CreateAccount(
        password: 'password',
        phone: 'phone',
        activationToken: '',
        birthday: DateTime.parse('2021-01-01'),
        firstname: '',
        floor: '',
        name: '',
        nickname: '',
        promo: 1,
      );
      CreateAccount newCreateAccount = createAccount.copyWith(
        password: 'newPassword',
      );
      expect(newCreateAccount.password, 'newPassword');
      newCreateAccount = createAccount.copyWith(phone: 'newPhone');
      expect(newCreateAccount.phone, 'newPhone');
      newCreateAccount = newCreateAccount.copyWith(
        activationToken: 'newActivationToken',
      );
      expect(newCreateAccount.activationToken, 'newActivationToken');
      newCreateAccount = newCreateAccount.copyWith(
        birthday: DateTime.parse('2021-02-02'),
      );
      expect(newCreateAccount.birthday, DateTime.parse('2021-02-02'));
      newCreateAccount = newCreateAccount.copyWith(firstname: 'newFirstname');
      expect(newCreateAccount.firstname, 'newFirstname');
      newCreateAccount = newCreateAccount.copyWith(floor: 'newFloor');
      expect(newCreateAccount.floor, 'newFloor');
      newCreateAccount = newCreateAccount.copyWith(name: 'newName');
      expect(newCreateAccount.name, 'newName');
      newCreateAccount = newCreateAccount.copyWith(nickname: 'newNickname');
      expect(newCreateAccount.nickname, 'newNickname');
      newCreateAccount = newCreateAccount.copyWith(promo: 2);
      expect(newCreateAccount.promo, 2);
    });

    test('Should print a createAccount', () {
      final createAccount = CreateAccount(
        password: 'password',
        phone: 'phone',
        activationToken: '',
        birthday: DateTime.parse('2021-01-01'),
        firstname: '',
        floor: '',
        name: '',
        nickname: '',
        promo: 1,
      );
      expect(
        createAccount.toString(),
        'CreateAccount {name: , firstname: , nickname: , password: password, birthday: 2021-01-01 00:00:00.000, phone: phone, promo: 1, floor: , activationToken: }',
      );
    });

    test('Should parse a createAccount', () {
      final createAccount = CreateAccount.fromJson({
        "name": "",
        "nickname": "",
        "firstname": "",
        "password": "password",
        "birthday": "2021-01-01",
        "phone": "phone",
        "floor": "",
        "activation_token": "",
      });
      expect(createAccount, isA<CreateAccount>());
      expect(createAccount.password, 'password');
      expect(createAccount.phone, 'phone');
      expect(createAccount.activationToken, '');
      expect(createAccount.birthday, DateTime.parse('2021-01-01'));
      expect(createAccount.firstname, '');
      expect(createAccount.floor, '');
      expect(createAccount.name, '');
      expect(createAccount.nickname, '');
    });

    test('Should return a correct json', () {
      final createAccount = CreateAccount.fromJson({
        "password": "password",
        "phone": "phone",
        "activation_token": "",
        "birthday": "2021-01-01",
        "firstname": "",
        "floor": "",
        "name": "",
        "nickname": "",
      });
      expect(createAccount.toJson(), {
        'name': '',
        'firstname': '',
        'nickname': '',
        'password': 'password',
        'birthday': '2021-01-01',
        'phone': 'phone',
        'floor': '',
        'promo': null,
        'activation_token': '',
      });
    });
  });

  group('Account Type Utils', () {
    test('Account Type to ID - Student', () {
      expect(
        accountTypeToID(AccountType.student),
        '39691052-2ae5-4e12-99d0-7a9f5f2b0136',
      );
    });

    test('Account Type to ID - Staff', () {
      expect(
        accountTypeToID(AccountType.staff),
        '703056c4-be9d-475c-aa51-b7fc62a96aaa',
      );
    });

    test('Account Type to ID - SuperAdmin', () {
      expect(
        accountTypeToID(AccountType.admin),
        '0a25cb76-4b63-4fd3-b939-da6d9feabf28',
      );
    });

    test('Account Type to ID - Association', () {
      expect(
        accountTypeToID(AccountType.association),
        '29751438-103c-42f2-b09b-33fbb20758a7',
      );
    });
  });
}
