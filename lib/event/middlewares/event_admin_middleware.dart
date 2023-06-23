import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/providers/is_admin.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EventAdminMiddleware extends QMiddleware {
  final ProviderRef ref;

  EventAdminMiddleware(this.ref);

  @override
  Future<String?> redirectGuard(String path) async {
    final isAdmin = ref.watch(isEventAdminProvider);
    if (isAdmin) {
      return null;
    } else {
      ref.read(pathForwardingProvider.notifier).forward(EventRouter.root);
      return EventRouter.root;
    }
  }
}
