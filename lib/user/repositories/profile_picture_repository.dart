import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class ProfilePictureRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'users/';

  Future<Uint8List> getProfilePicture(String id) async {
   return await getLogo(id, suffix: "/profile-picture/");
  }

  Future<Uint8List> addProfilePicture(String path) async {
    final image = await saveLogoToTemp(path);
    return await addLogo(image.path, "me", suffix: "/profile-picture");
  }
}
