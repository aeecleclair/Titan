import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/user/repositories/user_repository.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePictureNotifier extends SingleNotifier<Uint8List> {
  final UserRepository _userRepository = UserRepository();
  final ImagePicker _picker = ImagePicker();
  ProfilePictureNotifier(String token) : super(const AsyncLoading()) {
    _userRepository.setToken(token);
  }

  Future<AsyncValue<Uint8List>> getProfilePicture(String userId) async {
    return await load(() async => _userRepository.getProfilePicture(userId));
  }

  Future<AsyncValue<Uint8List>> getMyProfilePicture() async {
    return await load(() async => _userRepository.getProfilePicture("me"));
  }

  Future<bool?> setProfilePicture(ImageSource source) async {
    final previousState = state;
    state = const AsyncLoading();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      try {
        final i = await _userRepository.addProfilePicture(image.path);
        state = AsyncValue.data(i);
        return true;
      } catch (e) {
        state = previousState;
        return false;
      }
    }
    state = previousState;
    return null;
  }

  Future<bool?> cropImage() async {
    final previousState = state;
    state.whenData((value) async {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File file =
          await File('$tempPath/${DateTime.now().millisecondsSinceEpoch}.png')
              .create();

      // copies data byte by byte
      final File newImage = await file.writeAsBytes(value);

      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: newImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        try {
          final i = await _userRepository.addProfilePicture(croppedFile.path);
          state = AsyncValue.data(i);
          return true;
        } catch (e) {
          state = previousState;
          return false;
        }
      } else {
        state = previousState;
        return null;
      }
    });
    state = previousState;
    return null;
  }
}

final profilePictureProvider =
    StateNotifierProvider<ProfilePictureNotifier, AsyncValue<Uint8List>>((ref) {
  final token = ref.watch(tokenProvider);
  final userId = ref.watch(idProvider);
  ProfilePictureNotifier notifier = ProfilePictureNotifier(token);
  notifier.getProfilePicture(userId);
  return notifier;
});
