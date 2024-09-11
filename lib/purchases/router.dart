import 'package:either_dart/either.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/purchases/providers/purchases_admin_provider.dart';
import 'package:myecl/purchases/ui/pages/history_page/history_page.dart';
import 'package:myecl/purchases/ui/pages/main_page/main_page.dart';
import 'package:myecl/purchases/ui/pages/purchase_page/purchase_page.dart';
import 'package:myecl/purchases/ui/pages/scan_page/scan_page.dart';
import 'package:myecl/purchases/ui/pages/ticket_page/ticket_page.dart';
import 'package:myecl/purchases/ui/pages/user_list_page/user_list_page.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PurchasesRouter {
  final ProviderRef ref;
  static const String root = '/purchases';
  static const String scan = '/scan';
  static const String user_list = '/user_list';
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
        builder: () => const PurchasesMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: [
          QRoute(
            path: scan,
            builder: () => const ScanPage(),
            middleware: [
              AdminMiddleware(ref, isPurchasesAdminProvider),
            ],
          ),
          QRoute(
            path: history,
            builder: () => const HistoryPage(),
            children: [
              QRoute(
                path: purchase,
                builder: () => const PurchasePage(),
              ),
            ],
          ),
          QRoute(
            path: ticket,
            builder: () => const TicketPage(),
          ),
          QRoute(
            path: user_list,
            builder: () => const UserListPage(),
          ),
        ],
      );
}
