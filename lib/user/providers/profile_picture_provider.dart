import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/repositories/profile_picture_repository.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePictureNotifier extends SingleNotifier<Uint8List> {
  final ProfilePictureRepository _profilePictureRepository =
      ProfilePictureRepository();
  final ImagePicker _picker = ImagePicker();
  ProfilePictureNotifier(String token) : super(const AsyncLoading()) {
    _profilePictureRepository.setToken(token);
  }

  Future<AsyncValue<Uint8List>> getProfilePicture(String userId) async {
    return await load(
        () async => _profilePictureRepository.getProfilePicture(userId));
  }

  Future<AsyncValue<Uint8List>> getMyProfilePicture() async {
    return await load(
        () async => _profilePictureRepository.getProfilePicture("me"));
  }

  Future<bool?> setProfilePicture(ImageSource source) async {
    final previousState = state;
    state = const AsyncLoading();
    final XFile? image =
        await _picker.pickImage(source: source, imageQuality: 20);
    if (image != null) {
      try {
        final i = await _profilePictureRepository
            .addProfilePicture(await image.readAsBytes());
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
      File file = await File(
              '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png')
          .create();
      final File newImage = await file.writeAsBytes(value);
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: newImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Recadrer',
              toolbarColor: ColorConstants.gradient1,
              toolbarWidgetColor: Colors.grey[100],
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Recadrer',
          ),
        ],
      );
      if (croppedFile != null) {
        try {
          final i = await _profilePictureRepository
              .addProfilePicture(await croppedFile.readAsBytes());
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
  ProfilePictureNotifier notifier = ProfilePictureNotifier(token);
  tokenExpireWrapperAuth(ref, () async {
    notifier.getMyProfilePicture();
  });
  return notifier;
});
