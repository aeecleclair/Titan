import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/drawer/class/module.dart';
import 'package:titan/loan/providers/is_loan_admin_provider.dart';
import 'package:titan/loan/ui/pages/admin_page/admin_page.dart'
    deferred as admin_page;
import 'package:titan/loan/ui/pages/detail_pages/detail_loan.dart'
    deferred as detail_loan_page;
import 'package:titan/loan/ui/pages/item_group_page/add_edit_item_page.dart'
    deferred as add_edit_item_page;
import 'package:titan/loan/ui/pages/loan_group_page/add_edit_loan_page.dart'
    deferred as add_edit_loan_page;
import 'package:titan/loan/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoanRouter {
  final Ref ref;
  static const String root = '/loan';
  static const String admin = '/admin';
  static const String addEditLoan = '/add_edit_loan';
  static const String addEditItem = '/add_edit_item';
  static const String detail = '/detail';
  static final Module module = Module(
    name: "Prêt",
    icon: const Left(HeroIcons.buildingLibrary),
    root: LoanRouter.root,
    selected: false,
  );
  LoanRouter(this.ref);

  QRoute route() => QRoute(
    name: "loan",
    path: LoanRouter.root,
    builder: () => main_page.LoanMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    children: [
      QRoute(
        path: admin,
        builder: () => admin_page.AdminPage(),
        middleware: [
          AdminMiddleware(ref, isLoanAdminProvider),
          DeferredLoadingMiddleware(admin_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: detail,
            builder: () => detail_loan_page.DetailLoanPage(),
            middleware: [
              DeferredLoadingMiddleware(detail_loan_page.loadLibrary),
            ],
          ),
          QRoute(
            path: addEditLoan,
            builder: () => add_edit_loan_page.AddEditLoanPage(),
            middleware: [
              DeferredLoadingMiddleware(add_edit_loan_page.loadLibrary),
            ],
          ),
          QRoute(
            path: addEditItem,
            builder: () => add_edit_item_page.AddEditItemPage(),
            middleware: [
              DeferredLoadingMiddleware(add_edit_item_page.loadLibrary),
            ],
          ),
        ],
      ),
      QRoute(
        path: detail,
        builder: () => detail_loan_page.DetailLoanPage(),
        middleware: [DeferredLoadingMiddleware(detail_loan_page.loadLibrary)],
      ),
    ],
  );
}
