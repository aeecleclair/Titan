import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class PretendanceLogoRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/lists/';

  Future<Image> getPretendenceLogo(String id) async {
    final uint8List = await getLogo(id, suffix: "/logo");
    if (uint8List.isEmpty) {
      return Image.asset("assets/images/logo.png");
    }
    return Image.memory(uint8List);
  }

  Future<Image> addPretendenceLogo(Uint8List bytes, String id) async {
    final uint8List = await addLogo(bytes, id, suffix: "/logo");
    return Image.memory(uint8List);
  }
}
