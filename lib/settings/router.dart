import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/settings/ui/pages/edit_user_page/edit_user_page.dart'
    deferred as edit_user_page;
import 'package:titan/settings/ui/pages/log_page/log_page.dart'
    deferred as log_page;
import 'package:titan/settings/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/settings/ui/pages/modules_page/modules_page.dart'
    deferred as modules_page;
import 'package:titan/settings/ui/pages/notification_page/notification_page.dart'
    deferred as notification_page;
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SettingsRouter {
  final Ref ref;
  static const String root = '/settings';
  static const String editAccount = '/edit_account';
  static const String logs = '/logs';
  static const String modules = '/modules';
  static const String notifications = '/notifications';
  SettingsRouter(this.ref);

  QRoute route() => QRoute(
    name: "settings",
    path: SettingsRouter.root,
    builder: () => main_page.SettingsMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    children: [
      QRoute(
        path: editAccount,
        builder: () => edit_user_page.EditUserPage(),
        middleware: [DeferredLoadingMiddleware(edit_user_page.loadLibrary)],
      ),
      if (!kIsWeb)
        QRoute(
          path: logs,
          builder: () => log_page.LogPage(),
          middleware: [DeferredLoadingMiddleware(log_page.loadLibrary)],
        ),
      QRoute(
        path: modules,
        builder: () => modules_page.ModulesPage(),
        middleware: [DeferredLoadingMiddleware(modules_page.loadLibrary)],
      ),
      QRoute(
        path: notifications,
        builder: () => notification_page.NotificationPage(),
        middleware: [DeferredLoadingMiddleware(notification_page.loadLibrary)],
      ),
    ],
  );
}
