import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/settings/ui/pages/change_pass/change_pass.dart';
import 'package:myecl/settings/ui/pages/edit_user_page/edit_user_page.dart';
import 'package:myecl/settings/ui/pages/log_page/log_page.dart';
import 'package:myecl/settings/ui/pages/main_page/main_page.dart';
import 'package:myecl/settings/ui/pages/modules_page/modules_page.dart';
import 'package:myecl/settings/ui/pages/notification_page/notification_page.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SettingsRouter {
  final ProviderRef ref;
  static const String root = '/settings';
  static const String editAccount = '/edit_account';
  static const String changePassword = '/change_password';
  static const String logs = '/logs';
  static const String modules = '/modules';
  static const String notifications = '/notifications';
  SettingsRouter(this.ref);

  QRoute route() => QRoute(
          path: SettingsRouter.root,
          builder: () => const SettingsMainPage(),
          middleware: [
            AuthenticatedMiddleware(ref)
          ],
          children: [
            QRoute(path: editAccount, builder: () => const EditUserPage()),
            QRoute(path: changePassword, builder: () => const ChangePassPage()),
            QRoute(path: logs, builder: () => const LogPage()),
            QRoute(path: modules, builder: () => const ModulesPage()),
            QRoute(
                path: notifications, builder: () => const NotificationPage()),
          ]);
}
