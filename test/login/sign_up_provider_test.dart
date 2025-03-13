import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:myecl/login/providers/sign_up_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class MockSignUpRepository extends Mock implements Openapi {}

void main() {
  group('SignUpProvider', () {
    late MockSignUpRepository mockRepository;
    late SignUpProvider provider;
    final createAccount = CoreUserActivateRequest(
      name: 'Test',
      firstname: 'User',
      nickname: 'Tester',
      activationToken: 'token',
      password: 'password',
      birthday: DateTime.now(),
      phone: '1234567890',
      floor: '1',
      promo: '2023',
    );
    final recoverRequest = ResetPasswordRequest(
      resetToken: 'token',
      newPassword: 'newpassword',
    );

    setUp(() {
      mockRepository = MockSignUpRepository();
      provider = SignUpProvider(signUpRepository: mockRepository);
    });

    test('createUser returns true on success', () async {
      when(() => mockRepository.usersCreatePost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      final result = await provider.createUser('test@example.com');

      expect(result, true);
    });

    test('recoverUser returns true on success', () async {
      when(() => mockRepository.usersRecoverPost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      final result = await provider.recoverUser('test@example.com');

      expect(result, true);
    });

    test('activateUser returns true on success', () async {
      when(() => mockRepository.usersActivatePost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      final result = await provider.activateUser(createAccount);

      expect(result, true);
    });

    test('resetPassword returns true on success', () async {
      when(
        () => mockRepository.usersResetPasswordPost(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      final result = await provider.resetPassword(recoverRequest);

      expect(result, true);
    });
  });
}
