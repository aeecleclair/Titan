import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class ProfilePictureRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'users/';

  ProfilePictureRepository(super.ref);

  Future<Uint8List> getProfilePicture(String id) async {
    return await getLogo(id, suffix: "/profile-picture");
  }

  Future<Uint8List> addProfilePicture(Uint8List bytes) async {
    return await addLogo(bytes, "me", suffix: "/profile-picture");
  }
}

final profilePictureRepositoryProvider = Provider((ref) {
  return ProfilePictureRepository(ref);
});
