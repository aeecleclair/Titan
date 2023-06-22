import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/providers/is_admin.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminMiddleware extends QMiddleware {
  final ProviderRef ref;

  AdminMiddleware(this.ref);

  @override
  Future<String?> redirectGuard(String path) async {
    final isAdmin = ref.watch(isAdminProvider);
    return isAdmin ? null : '/';
  }
}
