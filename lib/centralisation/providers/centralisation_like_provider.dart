import 'package:flutter_riverpod/flutter_riverpod.dart';
import'package:myecl/centralisation/class/module.dart';

class ModulesNotifier extends StateNotifier<List<Module>> {
  List<Module> allModules = [
    Module(
      name: ""
    )
  ]
}