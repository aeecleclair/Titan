import 'package:flutter/material.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class SessionPosterRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'cinema/sessions/';

  Future<Image> getPretendenceLogo(String id) async {
    return await getLogo(id, suffix: "/poster");
  }

  Future<Image> addPretendenceLogo(String path, String id) async {
    final image = await saveLogoToTemp(path);
    return await addLogo(image.path, id, suffix: "/poster");
  }
}
