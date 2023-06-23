import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/loan/middlewares/loan_admin_middleware.dart';
import 'package:myecl/loan/ui/pages/detail_pages/detail_loan.dart';
import 'package:myecl/loan/ui/pages/item_group_page/add_edit_item_page.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/add_edit_loan_page.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoanRouter {
  final ProviderRef ref;
  static const String root = '/loan';
  static const String admin = '/admin';
  static const String addEditLoan = '/add_edit_loan';
  static const String addEditItem = '/add_edit_item';
  static const String detail = '/detail';
  late List<QRoute> routes = [];
  LoanRouter(this.ref) {
    routes = [
      QRoute(path: admin, builder: () => const AdminPage(), middleware: [
        LoanAdminMiddleware(ref),
      ], children: [
        QRoute(path: detail, builder: () => const DetailLoanPage()),
        QRoute(
            path: addEditLoan,
            builder: () => const AddEditLoanPage()),
        QRoute(
            path: addEditItem,
            builder: () => const AddEditItemPage()),
      ]),
      QRoute(path: detail, builder: () => const DetailLoanPage()),
    ];
  }
}
