import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/logo_repository.dart';

class AssociationLogoRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "association/";

  Future<Image> getAssociationLogo(String id) async {
    final uint8List = await getLogo("", suffix: "associations/$id/logo");
    if (uint8List.isEmpty) {
      return Image.asset(getTitanLogo());
    }
    return Image.memory(uint8List);
  }

  Future<Image> addAssociationLogo(Uint8List bytes, String id) async {
    final uint8List = await addLogo(bytes, "", suffix: "associations/$id/logo");
    return Image.memory(uint8List);
  }
}
