import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/user/repositories/user_repository.dart';

class ProfilePictureNotifier extends SingleNotifier<File> {
  final UserRepository _userRepository = UserRepository();
  ProfilePictureNotifier(String token) : super(const AsyncLoading()) {
    _userRepository.setToken(token);
  }

  Future<AsyncValue<File>> getProfilePicture(String userId) async {
    return await load(() async => _userRepository.getProfilePicture(userId));
  }

  Future<AsyncValue<File>> getMyProfilePicture() async {
    return await load(() async => _userRepository.getProfilePicture("me"));
  }

  Future<bool> setProfilePicture(File file) async {
    return await add(_userRepository.addProfilePicture, file);
  }
}

final profilePictureProvider =
    StateNotifierProvider<ProfilePictureNotifier, AsyncValue<File>>((ref) {
  final token = ref.watch(tokenProvider);
  ProfilePictureNotifier notifier = ProfilePictureNotifier(token);
  notifier.getMyProfilePicture();
  return notifier;
});
