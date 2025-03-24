import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/repositories/profile_picture_repository.dart';

class MyProfilePictureNotifier extends SingleNotifier<Uint8List> {
  final ProfilePictureRepository profilePictureRepository;
  MyProfilePictureNotifier({required this.profilePictureRepository})
      : super(const AsyncLoading());

  Future<AsyncValue<Uint8List>> getProfilePicture(String userId) async {
    return await load(
      () async => profilePictureRepository.getProfilePicture(userId),
    );
  }
}

final myProfilePictureProvider =
    StateNotifierProvider<MyProfilePictureNotifier, AsyncValue<Uint8List>>(
        (ref) {
  final profilePictureRepository = ref.watch(profilePictureRepositoryProvider);
  MyProfilePictureNotifier notifier = MyProfilePictureNotifier(
    profilePictureRepository: profilePictureRepository,
  );
  tokenExpireWrapperAuth(ref, () async {
    notifier.getProfilePicture("me");
  });
  return notifier;
});
