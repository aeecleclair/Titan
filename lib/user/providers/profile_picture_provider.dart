import 'dart:io';
import 'dart:typed_data';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePictureNotifier extends SingleNotifier<Uint8List> {
  final ImagePicker _picker = ImagePicker();

  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<Uint8List> build() {
    getMyProfilePicture();
    return const AsyncLoading();
  }

  Future<AsyncValue<Uint8List>> getProfilePicture(String userId) async {
    return await load(
      () async => (await repository.usersUserIdProfilePictureGet(
        userId: userId,
      )).bodyBytes,
    );
  }

  Future<AsyncValue<Uint8List>> getMyProfilePicture() async {
    return await load(
      () async => (await repository.usersUserIdProfilePictureGet(
        userId: "me",
      )).bodyBytes,
    );
  }

  Future<bool?> setProfilePicture(ImageSource source) async {
    final previousState = state;
    state = const AsyncLoading();
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 20,
    );
    if (image != null) {
      try {
        final bytes = await image.readAsBytes();
        await repository.usersMeProfilePicturePost(image: bytes);
        state = AsyncValue.data(bytes);
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
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png',
      ).create();
      final File newImage = await file.writeAsBytes(value);
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: newImage.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Recadrer',
            toolbarColor: ColorConstants.gradient1,
            toolbarWidgetColor: Colors.grey[100],
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
          IOSUiSettings(
            title: 'Recadrer',
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
        ],
      );
      if (croppedFile != null) {
        try {
          final bytes = await croppedFile.readAsBytes();
          await repository.usersMeProfilePicturePost(image: bytes);
          state = AsyncValue.data(bytes);
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
    NotifierProvider<ProfilePictureNotifier, AsyncValue<Uint8List>>(
      ProfilePictureNotifier.new,
    );
