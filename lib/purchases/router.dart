import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/purchases/providers/purchases_admin_provider.dart';
import 'package:titan/purchases/ui/pages/history_page/history_page.dart';
import 'package:titan/purchases/ui/pages/main_page/main_page.dart';
import 'package:titan/purchases/ui/pages/purchase_page/purchase_page.dart';
import 'package:titan/purchases/ui/pages/scan_page/scan_page.dart';
import 'package:titan/purchases/ui/pages/ticket_page/ticket_page.dart';
import 'package:titan/purchases/ui/pages/user_list_page/user_list_page.dart';
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PurchasesRouter {
  final Ref ref;
  static const String root = '/purchases';
  static const String scan = '/scan';
  static const String userList = '/user_list';
  static const String history = '/history';
  static const String ticket = '/ticket';
  static const String purchase = '/purchase';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.modulePurchases,
    getDescription: (context) =>
        AppLocalizations.of(context)!.modulePurchasesDescription,
    root: PurchasesRouter.root,
  );
  PurchasesRouter(this.ref);

  QRoute route() => QRoute(
    name: "purchases",
    path: PurchasesRouter.root,
    builder: () => const PurchasesMainPage(),
    middleware: [AuthenticatedMiddleware(ref)],
    pageType: QCustomPage(
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
    children: [
      QRoute(
        path: scan,
        builder: () => const ScanPage(),
        middleware: [AdminMiddleware(ref, isPurchasesAdminProvider)],
      ),
      QRoute(
        path: history,
        builder: () => const HistoryPage(),
        children: [QRoute(path: purchase, builder: () => const PurchasePage())],
      ),
      QRoute(path: ticket, builder: () => const TicketPage()),
      QRoute(path: userList, builder: () => const UserListPage()),
    ],
  );
}
