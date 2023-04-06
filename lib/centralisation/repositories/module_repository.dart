import 'package:flutter/gestures.dart';
import 'package:myecl/centralisation/class/module.dart';
import 'package:myecl/tools/repository/repository.dart';

class ModuleRepository extends Repository {
  @override
  final ext = "/centralisation";

  Future<List<Module>> getModulesList() async {
    return List<Module>.from(await getList(suffix: ))
  }
}