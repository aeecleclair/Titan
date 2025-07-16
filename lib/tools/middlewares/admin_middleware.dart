import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SuperAdminMiddleware extends QMiddleware {
  final StateProvider<bool> isSuperAdminProvider;
  final Ref ref;

  SuperAdminMiddleware(this.ref, this.isSuperAdminProvider);

  @override
  Future<String?> redirectGuard(String path) async {
    return ref.watch(isSuperAdminProvider) ? null : AppRouter.root;
  }
}
