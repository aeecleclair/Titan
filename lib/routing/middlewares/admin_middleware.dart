import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminMiddleware extends QMiddleware {
  final StateProvider<bool> isAdminProvider;
  final Ref ref;

  AdminMiddleware(this.ref, this.isAdminProvider);

  @override
  Future<String?> redirectGuard(String path) async {
    final isAdmin = ref.read(isAdminProvider);
    return isAdmin ? null : AppRouter.root;
  }
}
