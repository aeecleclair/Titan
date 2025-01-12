import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/repositories/profile_picture_repository.dart';

class ProfilePictureNotifier extends SingleNotifier<Uint8List> {
  final ProfilePictureRepository profilePictureRepository;
  ProfilePictureNotifier({required this.profilePictureRepository})
      : super(const AsyncLoading());

  Future<AsyncValue<Uint8List>> getProfilePicture(String userId) async {
    return await load(
      () async => profilePictureRepository.getProfilePicture(userId),
    );
  }
}

final profilePictureProvider =
    StateNotifierProvider<ProfilePictureNotifier, AsyncValue<Uint8List>>((ref) {
  final profilePictureRepository = ref.watch(profilePictureRepositoryProvider);
  ProfilePictureNotifier notifier = ProfilePictureNotifier(
    profilePictureRepository: profilePictureRepository,
  );
  tokenExpireWrapperAuth(ref, () async {
    notifier.getProfilePicture("me");
  });
  return notifier;
});
