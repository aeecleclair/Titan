import 'package:either_dart/either.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/drawer/class/module.dart';
import 'package:titan/purchases/providers/purchases_admin_provider.dart';
import 'package:titan/purchases/ui/pages/history_page/history_page.dart'
    deferred as history_page;
import 'package:titan/purchases/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/purchases/ui/pages/purchase_page/purchase_page.dart'
    deferred as purchase_page;
import 'package:titan/purchases/ui/pages/scan_page/scan_page.dart'
    deferred as scan_page;
import 'package:titan/purchases/ui/pages/ticket_page/ticket_page.dart'
    deferred as ticket_page;
import 'package:titan/purchases/ui/pages/user_list_page/user_list_page.dart'
    deferred as user_list_page;
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';

class PurchasesRouter {
  final Ref ref;
  static const String root = '/purchases';
  static const String scan = '/scan';
  static const String userList = '/user_list';
  static const String history = '/history';
  static const String ticket = '/ticket';
  static const String purchase = '/purchase';
  static final Module module = Module(
    name: "Achats",
    icon: const Left(HeroIcons.shoppingBag),
    root: PurchasesRouter.root,
    selected: false,
  );
  PurchasesRouter(this.ref);

  QRoute route() => QRoute(
    name: "purchases",
    path: PurchasesRouter.root,
    builder: () => main_page.PurchasesMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    children: [
      QRoute(
        path: scan,
        builder: () => scan_page.ScanPage(),
        middleware: [
          AdminMiddleware(ref, isPurchasesAdminProvider),
          DeferredLoadingMiddleware(scan_page.loadLibrary),
        ],
      ),
      QRoute(
        path: history,
        builder: () => history_page.HistoryPage(),
        middleware: [DeferredLoadingMiddleware(history_page.loadLibrary)],
        children: [
          QRoute(
            path: purchase,
            builder: () => purchase_page.PurchasePage(),
            middleware: [DeferredLoadingMiddleware(purchase_page.loadLibrary)],
          ),
        ],
      ),
      QRoute(
        path: ticket,
        builder: () => ticket_page.TicketPage(),
        middleware: [DeferredLoadingMiddleware(ticket_page.loadLibrary)],
      ),
      QRoute(
        path: userList,
        builder: () => user_list_page.UserListPage(),
        middleware: [
          AdminMiddleware(ref, isPurchasesAdminProvider),
          DeferredLoadingMiddleware(user_list_page.loadLibrary),
        ],
      ),
    ],
  );
}
