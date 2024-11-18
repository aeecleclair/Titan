import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:qlevar_router/qlevar_router.dart';

abstract class ModuleRouter {
  final ProviderRef ref;
  static late String root;
  static late Module module;
  ModuleRouter(this.ref);

  QRoute route();
  // ModuleRouter initialize(ref);
  Module getModule() => module;
}
