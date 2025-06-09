import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/user/repositories/profile_picture_repository.dart';

final profilePictureProvider =
    StateNotifierProvider<ProfilePictureNotifier, AsyncValue<Image>>((ref) {
      final profilePictureRepository = ref.watch(
        profilePictureRepositoryProvider,
      );
      return ProfilePictureNotifier(profilePictureRepository);
    });

class ProfilePictureNotifier extends SingleNotifier<Image> {
  final ProfilePictureRepository profilePictureRepository;
  ProfilePictureNotifier(this.profilePictureRepository)
    : super(const AsyncLoading());

  Future<Image> getProfilePicture(String profileId) async {
    return Image.memory(
      await profilePictureRepository.getProfilePicture(profileId),
    );
  }
}
