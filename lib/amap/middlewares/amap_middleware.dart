import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/is_amap_admin_provider.dart';
import 'package:myecl/amap/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AmapAdminMiddleware extends QMiddleware {
  final ProviderRef ref;

  AmapAdminMiddleware(this.ref);

  @override
  Future<String?> redirectGuard(String path) async {
    final isAdmin = ref.watch(isAmapAdminProvider);
    return isAdmin ? null : AmapRouter.root;
  }
}
