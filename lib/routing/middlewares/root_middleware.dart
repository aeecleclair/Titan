import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/router.dart';
import 'package:myecl/settings/providers/module_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RootMiddleware extends QMiddleware {
  final Ref ref;

  RootMiddleware(this.ref) : super(priority: 1000);

  @override
  Future<bool> canPop() {
    return Future.value(false);
  }

  @override
  Future<String?> redirectGuard(String path) async {
    final modules = ref.watch(modulesProvider);
    return modules.isNotEmpty ? modules.first.root : AppRouter.noModule;
  }
}
