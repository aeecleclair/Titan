import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/user/class/user.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:titan/user/repositories/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UserNotifier userNotifier;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    userNotifier = UserNotifier(userRepository: mockUserRepository);
  });

  group('setUser', () {
    test('should return true when user is added successfully', () async {
      final user = User.empty();
      userNotifier.state = AsyncValue.data(user);
      final result = await userNotifier.setUser(user);
      expect(result, true);
    });
  });

  group('loadUser', () {
    test('should return AsyncValue when user is loaded successfully', () async {
      final user = User.empty().copyWith(id: '123');
      when(
        () => mockUserRepository.getUser(user.id),
      ).thenAnswer((_) async => user);
      final result = await userNotifier.loadUser('123');
      expect(result, AsyncValue.data(user));
    });
  });

  group('loadMe', () {
    test('should return AsyncValue when user is loaded successfully', () async {
      final user = User.empty();
      when(() => mockUserRepository.getMe()).thenAnswer((_) async => user);
      final result = await userNotifier.loadMe();
      expect(result, AsyncValue.data(user));
    });
  });

  group('updateUser', () {
    test('should return true when user is updated successfully', () async {
      final user = User.empty();
      when(
        () => mockUserRepository.updateUser(user),
      ).thenAnswer((_) async => true);
      userNotifier.state = AsyncValue.data(user);
      final result = await userNotifier.updateUser(user);
      expect(result, true);
    });
  });

  group('updateMe', () {
    test('should return true when user is updated successfully', () async {
      final user = User.empty();
      when(
        () => mockUserRepository.updateMe(user),
      ).thenAnswer((_) async => true);
      userNotifier.state = AsyncValue.data(user);
      final result = await userNotifier.updateMe(user);
      expect(result, true);
    });
  });

  group('deletePersonal', () {
    test(
      'should return true when personal data is deleted successfully',
      () async {
        when(
          () => mockUserRepository.deletePersonalData(),
        ).thenAnswer((_) async => true);
        final result = await userNotifier.deletePersonal();
        expect(result, true);
      },
    );
  });
}
