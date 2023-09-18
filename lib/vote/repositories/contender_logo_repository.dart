import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class ContenderLogoRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/lists/';

  Future<Image> getContenderLogo(String id) async {
    final bytes = await getLogo(id, suffix: "/logo");
    if (bytes.isEmpty) {
      return Image.asset("assets/images/logo.png");
    }
    return Image.memory(bytes);
  }

  Future<Image> addContenderLogo(Uint8List bytes, String id) async {
    return Image.memory(await addLogo(bytes, id, suffix: "/logo"));
  }
}
