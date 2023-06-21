import 'package:myecl/settings/ui/pages/change_pass/change_pass.dart';
import 'package:myecl/settings/ui/pages/edit_user_page/edit_user_page.dart';
import 'package:myecl/settings/ui/pages/log_page/log_page.dart';
import 'package:myecl/settings/ui/pages/modules_page/modules_page.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SettingsRouter {
  static const String root = '/settings';
  static const String editAccount = '/edit_account';
  static const String changePassword = '/change_password';
  static const String logs = '/logs';
  static const String modules = '/modules';
  late List<QRoute> routes = [];
  SettingsRouter() {
    routes = [
      QRoute(
          path: editAccount,
          builder: () => const EditUserPage()),
      QRoute(
          path: changePassword,
          builder: () => const ChangePassPage()),
      QRoute(
          path: logs, builder: () => const LogPage()),
      QRoute(
          path: modules,
          builder: () => const ModulesPage()),
    ];
  }
}
