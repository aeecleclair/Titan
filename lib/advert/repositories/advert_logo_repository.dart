import  'dart:async';

import 'package:flutter/material.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class AdvertPosterRepository extends LogoRepository {
  @override
  final ext = 'advert/';

  Future<Image> getAdvertLogo(String id) async {
    final uint8List = await getLogo(id, suffix: "/poster");
    if (uint8List.isEmpty) {
      return Image.asset("assets/images/logo.png");
    }
    return Image.memory(uint8List);
  }

  Future<Image> addAdvertLogo(String path, String id) async {
    final image = await saveLogoToTemp(path);
    final uint8List = await addLogo(image.path, id, suffix: "/poster");
    return Image.memory(uint8List);
  }
} 