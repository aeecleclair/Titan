import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminMiddleware extends QMiddleware {
  final ProviderBase<bool> isAdminProvider;
  final Ref ref;

  AdminMiddleware(this.ref, this.isAdminProvider);

  @override
  Future<String?> redirectGuard(String path) async {
    return ref.watch(isAdminProvider) ? null : AppRouter.root;
  }
}
