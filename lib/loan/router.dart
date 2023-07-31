import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/loan/providers/is_loan_admin_provider.dart';
import 'package:myecl/loan/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/loan/ui/pages/detail_pages/detail_loan.dart';
import 'package:myecl/loan/ui/pages/item_group_page/add_edit_item_page.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/add_edit_loan_page.dart';
import 'package:myecl/loan/ui/pages/main_page/main_page.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoanRouter {
  final ProviderRef ref;
  static const String root = '/loan';
  static const String admin = '/admin';
  static const String addEditLoan = '/add_edit_loan';
  static const String addEditItem = '/add_edit_item';
  static const String detail = '/detail';
  static final Module module = Module(
      name: "Prêt",
      icon: const Left(HeroIcons.buildingLibrary),
      root: LoanRouter.root,
      selected: false);
  LoanRouter(this.ref);

  QRoute route() => QRoute(
        path: LoanRouter.root,
        builder: () => const LoanMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: [
          QRoute(path: admin, builder: () => const AdminPage(), middleware: [
            AdminMiddleware(ref, isLoanAdminProvider),
          ], children: [
            QRoute(path: detail, builder: () => const DetailLoanPage()),
            QRoute(path: addEditLoan, builder: () => const AddEditLoanPage()),
            QRoute(path: addEditItem, builder: () => const AddEditItemPage()),
          ]),
          QRoute(path: detail, builder: () => const DetailLoanPage()),
        ],
      );
}
