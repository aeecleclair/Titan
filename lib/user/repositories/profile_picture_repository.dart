import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/user/repositories/user_repository.dart';

class ProfilePictureNotifier extends SingleNotifier<Image> {
  final UserRepository _userRepository = UserRepository();
  final ImagePicker _picker = ImagePicker();
  ProfilePictureNotifier(String token) : super(const AsyncLoading()) {
    _userRepository.setToken(token);
  }

  Future<AsyncValue<Image>> getProfilePicture(String userId) async {
    return await load(() async => _userRepository.getProfilePicture(userId));
  }

  Future<AsyncValue<Image>> getMyProfilePicture() async {
    return await load(() async => _userRepository.getProfilePicture("me"));
  }

  Future<AsyncValue<Image>> setProfilePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return state =
          AsyncValue.data(await _userRepository.addProfilePicture(image.path));
    } else {
      return AsyncError(Exception("No image selected"), StackTrace.empty);
    }
  }
}

final profilePictureProvider =
    StateNotifierProvider<ProfilePictureNotifier, AsyncValue<Image>>((ref) {
  final token = ref.watch(tokenProvider);
  final userId = ref.watch(idProvider);
  ProfilePictureNotifier notifier = ProfilePictureNotifier(token);
  notifier.getProfilePicture(userId);
  return notifier;
});
