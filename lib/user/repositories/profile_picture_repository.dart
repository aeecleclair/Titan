import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class ProfilePictureRepository {
  final Openapi client;
  ProfilePictureRepository(this.client);

  Future<Uint8List> getProfilePicture(String id) async {
    final response = await client.usersUserIdProfilePictureGet(userId: id);
    return response.bodyBytes;
  }

  Future<Uint8List> addProfilePicture(Uint8List bytes) async {
    await client.usersMeProfilePicturePost(image: bytes);
    return bytes;
  }
}

final profilePictureRepositoryProvider = Provider<ProfilePictureRepository>(
  (ref) => ProfilePictureRepository(ref.watch(repositoryProvider)),
);
