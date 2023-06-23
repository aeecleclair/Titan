import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/providers/is_cinema_admin.dart';
import 'package:myecl/cinema/router.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CinemaAdminMiddleware extends QMiddleware {
  final ProviderRef ref;

  CinemaAdminMiddleware(this.ref);

  @override
  Future<String?> redirectGuard(String path) async {
    final isAdmin = ref.watch(isCinemaAdminProvider);
    if (isAdmin) {
      return null;
    } else {
      ref.read(pathForwardingProvider.notifier).forward(CinemaRouter.root);
      return CinemaRouter.root;
    }
  }
}
