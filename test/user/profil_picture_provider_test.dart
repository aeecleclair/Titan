import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/user/providers/profile_picture_provider.dart';
import 'package:titan/user/repositories/profile_picture_repository.dart';

class MockProfilePictureRepository extends Mock
    implements ProfilePictureRepository {}

class MockXFile extends Mock implements XFile {}

void main() {
  group('ProfilePictureNotifier', () {
    late ProfilePictureRepository profilePictureRepository;
    late ProfilePictureNotifier profilePictureNotifier;

    setUp(() {
      profilePictureRepository = MockProfilePictureRepository();
      profilePictureNotifier = ProfilePictureNotifier(
        profilePictureRepository: profilePictureRepository,
      );
    });

    test('getProfilePicture returns AsyncValue<Uint8List>', () async {
      const userId = '123';
      final expected = Uint8List.fromList([1, 2, 3]);
      when(
        () => profilePictureRepository.getProfilePicture(userId),
      ).thenAnswer((_) async => expected);

      final result = await profilePictureNotifier.getProfilePicture(userId);

      expect(
        result.when(
          data: (data) => data,
          loading: () => null,
          error: (_, _) => null,
        ),
        expected,
      );
    });

    test('getMyProfilePicture returns AsyncValue<Uint8List>', () async {
      final expected = Uint8List.fromList([1, 2, 3]);
      when(
        () => profilePictureRepository.getProfilePicture('me'),
      ).thenAnswer((_) async => expected);

      final result = await profilePictureNotifier.getMyProfilePicture();

      expect(
        result.when(
          data: (data) => data,
          loading: () => null,
          error: (_, _) => null,
        ),
        expected,
      );
    });
  });
}
