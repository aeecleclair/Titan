import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/router.dart';
import 'package:myecl/service/provider_list.dart';
import 'package:qlevar_router/qlevar_router.dart';

class NotificationMiddleWare extends QMiddleware {
  final ProviderRef<AppRouter> ref;

  NotificationMiddleWare(this.ref);

  @override
  Future<void> onEnter() async {
    final actionModule = QR.params['actionModule'];
    final actionTable = QR.params['actionTable'];
    if (actionModule == null || actionTable == null) {
      return;
    }
    final provider = providers[actionModule.toString()];
    if (provider == null) {
      return;
    }
    final information = provider[actionTable.toString()];
    if (information == null) {
      return;
    }
    final notifier = information.item2;
    for (final provider in notifier) {
      // ignore: unused_result
      ref.refresh(provider);
    }
  }
}
