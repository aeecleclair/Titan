import 'package:myecl/admin/ui/pages/add_asso_page/add_asso_page.dart';
import 'package:myecl/admin/ui/pages/add_loaner_page/add_loaner_page.dart';
import 'package:myecl/admin/ui/pages/edit_page/edit_page.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminRouter {
  static const String root = '/admin';
  static const String addAsso = '/add_asso';
  static const String addLoaner = '/add_loaner';
  static const String editAsso = '/edit_asso';
  late List<QRoute> routes = [];
  AdminRouter() {
    routes = [
      QRoute(path: addAsso, builder: () => const AddAssoPage()),
      QRoute(path: addLoaner, builder: () => const AddLoanerPage()),
      QRoute(path: editAsso, builder: () => const EditAssoPage()),
    ];
  }
}
