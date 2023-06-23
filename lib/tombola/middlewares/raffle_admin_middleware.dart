import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tombola/providers/is_tombola_admin.dart';
import 'package:myecl/tombola/router.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RaffleAdminMiddleware extends QMiddleware {
  final ProviderRef ref;

  RaffleAdminMiddleware(this.ref);

  @override
  Future<String?> redirectGuard(String path) async {
    final isAdmin = ref.watch(isTombolaAdminProvider);
    if (isAdmin) {
      return null;
    } else {
      ref.read(pathForwardingProvider.notifier).forward(RaffleRouter.root);
      return RaffleRouter.root;
    }
  }
}
