import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:myecl/paiement/ui/pages/pay_page/pay_page.dart'
    deferred as pay_page;
import 'package:myecl/paiement/ui/pages/qr_page/qr_page.dart'
    deferred as qr_page;
import 'package:myecl/paiement/ui/pages/scan_page/scan_page.dart'
    deferred as scan_page;
import 'package:myecl/paiement/ui/pages/stats_page/stats_page.dart'
    deferred as stats_page;
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PaymentRouter {
  final ProviderRef ref;
  static const String root = '/payment';
  static const String stats = '/stats';
  static const String qr = '/qr';
  static const String pay = '/pay';
  static const String scan = '/scan';
  static final Module module = Module(
    name: "Paiement",
    icon: const Left(HeroIcons.creditCard),
    root: PaymentRouter.root,
    selected: false,
  );
  PaymentRouter(this.ref);

  QRoute route() => QRoute(
        name: "paiement",
        path: PaymentRouter.root,
        builder: () => main_page.PaymentMainPage(),
        middleware: [
          AuthenticatedMiddleware(ref),
          DeferredLoadingMiddleware(main_page.loadLibrary),
        ],
        children: [
          QRoute(
              path: PaymentRouter.pay,
              builder: () => pay_page.PayPage(),
              middleware: [
                DeferredLoadingMiddleware(pay_page.loadLibrary),
              ],
              children: [
                QRoute(
                  path: PaymentRouter.qr,
                  builder: () => qr_page.QrPage(),
                  middleware: [
                    DeferredLoadingMiddleware(qr_page.loadLibrary),
                  ],
                ),
              ],),
          QRoute(
            path: PaymentRouter.scan,
            builder: () => scan_page.ScanPage(),
            middleware: [
              DeferredLoadingMiddleware(scan_page.loadLibrary),
            ],
          ),
          QRoute(
            path: PaymentRouter.stats,
            builder: () => stats_page.StatsPage(),
            middleware: [
              DeferredLoadingMiddleware(stats_page.loadLibrary),
            ],
          ),
        ],
      );
}
