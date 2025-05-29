import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/login/class/account_type.dart';
import 'package:myecl/login/class/create_account.dart';
import 'package:myecl/login/class/recover_request.dart';
import 'package:myecl/login/providers/sign_up_provider.dart';
import 'package:myecl/login/repositories/sign_up_repository.dart';

class MockSignUpRepository extends Mock implements SignUpRepository {}

void main() {
  late SignUpProvider signUpProvider;
  late MockSignUpRepository mockSignUpRepository;

  setUp(() {
    mockSignUpRepository = MockSignUpRepository();
    signUpProvider = SignUpProvider(repository: mockSignUpRepository);
  });

  group('createUser', () {
    test('returns true when repository returns true', () async {
      when(
        () => mockSignUpRepository.createUser(
          'test@test.com',
          AccountType.student,
        ),
      ).thenAnswer((_) async => true);

      final result = await signUpProvider.createUser(
        'test@test.com',
        AccountType.student,
      );

      expect(result, true);
    });

    test('returns false when repository returns false', () async {
      when(
        () => mockSignUpRepository.createUser(
          'test@test.com',
          AccountType.student,
        ),
      ).thenAnswer((_) async => false);

      final result = await signUpProvider.createUser(
        'test@test.com',
        AccountType.student,
      );

      expect(result, false);
    });
  });

  group('recoverUser', () {
    test('returns true when repository returns true', () async {
      when(
        () => mockSignUpRepository.recoverUser('test@test.com'),
      ).thenAnswer((_) async => true);

      final result = await signUpProvider.recoverUser('test@test.com');

      expect(result, true);
    });

    test('returns false when repository returns false', () async {
      when(
        () => mockSignUpRepository.recoverUser('test@test.com'),
      ).thenAnswer((_) async => false);

      final result = await signUpProvider.recoverUser('test@test.com');

      expect(result, false);
    });
  });

  group('activateUser', () {
    test('returns true when repository returns true', () async {
      final createAccount = CreateAccount.empty().copyWith(
        password: 'password',
      );
      when(
        () => mockSignUpRepository.activateUser(createAccount),
      ).thenAnswer((_) async => true);

      final result = await signUpProvider.activateUser(createAccount);

      expect(result, true);
    });

    test('returns false when repository returns false', () async {
      final createAccount = CreateAccount.empty().copyWith(
        password: 'password',
      );
      when(
        () => mockSignUpRepository.activateUser(createAccount),
      ).thenAnswer((_) async => false);

      final result = await signUpProvider.activateUser(createAccount);

      expect(result, false);
    });
  });

  group('resetPassword', () {
    test('returns true when repository returns true', () async {
      final recoverRequest = RecoverRequest.empty().copyWith(
        newPassword: 'password',
      );
      when(
        () => mockSignUpRepository.resetPassword(recoverRequest),
      ).thenAnswer((_) async => true);

      final result = await signUpProvider.resetPassword(recoverRequest);

      expect(result, true);
    });

    test('returns false when repository returns false', () async {
      final recoverRequest = RecoverRequest.empty().copyWith(
        newPassword: 'password',
      );
      when(
        () => mockSignUpRepository.resetPassword(recoverRequest),
      ).thenAnswer((_) async => false);

      final result = await signUpProvider.resetPassword(recoverRequest);

      expect(result, false);
    });
  });
}
