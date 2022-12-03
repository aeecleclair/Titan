import 'package:flutter/material.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class PretendanceLogoRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/lists/';

  Future<Image> getPretendenceLogo(String id) async {
    print(ext + id);
    return await getLogo(id, suffix: "/logo");
  }

  Future<Image> addPretendenceLogo(String path, String id) async {
    return await addLogo(path, id, suffix: "/logo");
  }
}
