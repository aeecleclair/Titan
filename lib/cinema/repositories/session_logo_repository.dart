import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class SessionPosterRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'cinema/sessions/';

  Future<Image> getSessionLogo(String id) async {
    final uint8List = await getLogo(id, suffix: "/poster");
    if (uint8List.isEmpty) {
      return Image.asset("assets/images/logo.png");
    }
    return Image.memory(uint8List);
  }

  Future<Image> addSessionLogo(Uint8List bytes, String id) async {
    final uint8List = await addLogo(bytes, id, suffix: "/poster");
    return Image.memory(uint8List);
  }
}
