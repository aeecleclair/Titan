import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class AdvertPosterRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "advert/";

  Future<Image> getAdvertPoster(String id) async {
    final uint8List = await getLogo("", suffix: "adverts/$id/picture");
    if (uint8List.isEmpty) {
      return Image.asset("assets/images/logo.png");
    }
    return Image.memory(uint8List);
  }

  Future<Image> addAdvertPoster(Uint8List bytes, String id) async {
    final uint8List = await addLogo(bytes, "", suffix: "adverts/$id/picture");
    return Image.memory(uint8List);
  }
}
