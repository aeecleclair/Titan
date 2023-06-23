import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:myecl/vote/providers/is_vote_admin_provider.dart';
import 'package:myecl/vote/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class VoteAdminMiddleware extends QMiddleware {
  final ProviderRef ref;

  VoteAdminMiddleware(this.ref);

  @override
  Future<String?> redirectGuard(String path) async {
    final isAdmin = ref.watch(isVoteAdminProvider);
    if (isAdmin) {
      return null;
    } else {
      ref.read(pathForwardingProvider.notifier).forward(VoteRouter.root);
      return VoteRouter.root;
    }
  }
}
