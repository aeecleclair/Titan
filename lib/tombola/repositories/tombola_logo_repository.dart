import 'package:flutter/material.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class TombolaLogoRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'tombola/raffles/';

  Future<Image> getTombolaLogo(String id) async {
    final uint8List =  await getLogo(id, suffix: "/logo");
    print("Empty logo : ${uint8List.isEmpty}, id: $id");
    if (uint8List.isEmpty) {return Image.asset("assets/images/logo.png");}
    return Image.memory(uint8List);
  }

  Future<Image> addTombolaLogo(String path, String id) async {
    final uint8List =  await addLogo(path, id, suffix: "/logo");
    return Image.memory(uint8List);
  }
}