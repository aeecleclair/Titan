import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/user/repositories/profile_picture_repository.dart';

final profilePictureProvider =
    StateNotifierProvider<ProfilePictureNotifier, AsyncValue<Image>>((ref) {
      final token = ref.watch(tokenProvider);
      ProfilePictureNotifier notifier = ProfilePictureNotifier(token: token);
      return notifier;
    });

class ProfilePictureNotifier extends SingleNotifier<Image> {
  final ProfilePictureRepository profilePictureRepository =
      ProfilePictureRepository();
  ProfilePictureNotifier({required String token})
    : super(const AsyncLoading()) {
    profilePictureRepository.setToken(token);
  }

  Future<Image> getProfilePicture(String profileId) async {
    return Image.memory(
      await profilePictureRepository.getProfilePicture(profileId),
    );
  }
}
