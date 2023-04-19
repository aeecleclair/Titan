import 'package:flutter/gestures.dart';
import 'package:myecl/centralisation/class/module.dart';
import 'package:myecl/tools/repository/repository.dart';

class ModuleRepository extends Repository {
  @override
  final host = "https://centralisation.eclair.ec-lyon.fr/links.json";

  Future<List<Module>> getModuleList() async {
    return (await getList()).map((e) => Module.fromJson(e)).toList();
  }
}