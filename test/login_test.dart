import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/login/class/create_account.dart';
import 'package:myecl/login/class/recover_request.dart';

void main() {
  group('Testing RecoverRequest class', () {
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
      final recoverRequest =
          RecoverRequest(resetToken: 'token', newPassword: 'password');
      RecoverRequest newRecoverRequest = recoverRequest.copyWith(
        resetToken: 'newToken',
      );
      expect(newRecoverRequest.resetToken, 'newToken');
      newRecoverRequest = recoverRequest.copyWith(
        newPassword: 'newPassword',
      );
      expect(newRecoverRequest.newPassword, 'newPassword');
    });

    test('Should print a recoverRequest', () {
      final recoverRequest =
          RecoverRequest(resetToken: 'token', newPassword: 'password');
      expect(recoverRequest.toString(),
          'RecoverRequest{resetToken: token, newPassword: password}');
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
      );
      CreateAccount newCreateAccount = createAccount.copyWith(
        password: 'newPassword',
      );
      expect(newCreateAccount.password, 'newPassword');
      newCreateAccount = createAccount.copyWith(
        phone: 'newPhone',
      );
      expect(newCreateAccount.phone, 'newPhone');
      newCreateAccount = newCreateAccount.copyWith(
        activationToken: 'newActivationToken',
      );
      expect(newCreateAccount.activationToken, 'newActivationToken');
      newCreateAccount = newCreateAccount.copyWith(
        birthday: DateTime.parse('2021-02-02'),
      );
      expect(newCreateAccount.birthday, DateTime.parse('2021-02-02'));
      newCreateAccount = newCreateAccount.copyWith(
        firstname: 'newFirstname',
      );
      expect(newCreateAccount.firstname, 'newFirstname');
      newCreateAccount = newCreateAccount.copyWith(
        floor: 'newFloor',
      );
      expect(newCreateAccount.floor, 'newFloor');
      newCreateAccount = newCreateAccount.copyWith(
        name: 'newName',
      );
      expect(newCreateAccount.name, 'newName');
      newCreateAccount = newCreateAccount.copyWith(
        nickname: 'newNickname',
      );
      expect(newCreateAccount.nickname, 'newNickname');
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
      );
      expect(createAccount.toString(),
          'CreateAccount {name: , firstname: , nickname: , password: password, birthday: 2021-01-01 00:00:00.000, phone: phone, floor: , activationToken: }');
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
        "password": "password",
        "phone": "phone",
        "activation_token": "",
        "birthday": "2021-01-01",
        "firstname": "",
        "floor": "",
        "name": "",
        "nickname": "",
      });
    });
  });
}
