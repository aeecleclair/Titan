import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/paiement/providers/is_payment_admin.dart';
import 'package:myecl/paiement/ui/pages/admin_page/admin_page.dart'
    deferred as admin_page;
import 'package:myecl/paiement/ui/pages/store_pages/add_edit_store.dart'
    deferred as add_edit_page;
import 'package:myecl/paiement/ui/pages/store_admin_page/store_admin_page.dart'
    deferred as store_admin_page;
import 'package:myecl/paiement/ui/pages/admin_store_admin_page/admin_store_admin_page.dart'
    deferred as admin_store_admin_page;
import 'package:myecl/paiement/ui/pages/devices_page/devices_page.dart'
    deferred as devices_page;
import 'package:myecl/paiement/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:myecl/paiement/ui/pages/stats_page/stats_page.dart'
    deferred as stats_page;
import 'package:myecl/paiement/ui/pages/store_stats_page/store_stats_page.dart'
    deferred as store_stats_page;
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PaymentRouter {
  final Ref ref;
  static const String root = '/payment';
  static const String stats = '/stats';
  static const String devices = '/devices';
  static const String admin = '/admin';
  static const String addEditStore = '/addEditStore';
  static const String storeAdmin = '/storeAdmin';
  static const String storeStats = '/storeStats';
  static final Module module = Module(
    name: "MyECLPay",
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
            path: PaymentRouter.stats,
            builder: () => stats_page.StatsPage(),
            middleware: [
              DeferredLoadingMiddleware(stats_page.loadLibrary),
            ],
          ),
          QRoute(
            path: PaymentRouter.devices,
            builder: () => devices_page.DevicesPage(),
            middleware: [
              DeferredLoadingMiddleware(devices_page.loadLibrary),
            ],
          ),
          QRoute(
            path: PaymentRouter.storeAdmin,
            builder: () => store_admin_page.StoreAdminPage(),
            middleware: [
              DeferredLoadingMiddleware(store_admin_page.loadLibrary),
            ],
          ),
          QRoute(
            path: PaymentRouter.admin,
            builder: () => admin_page.AdminPage(),
            middleware: [
              DeferredLoadingMiddleware(admin_page.loadLibrary),
              AdminMiddleware(ref, isPaymentAdminProvider),
            ],
            children: [
              QRoute(
                path: PaymentRouter.addEditStore,
                builder: () => add_edit_page.AddEditStorePage(),
                middleware: [
                  DeferredLoadingMiddleware(add_edit_page.loadLibrary),
                ],
              ),
              QRoute(
                path: PaymentRouter.storeAdmin,
                builder: () => admin_store_admin_page.AdminStoreAdminPage(),
                middleware: [
                  DeferredLoadingMiddleware(
                    admin_store_admin_page.loadLibrary,
                  ),
                ],
              ),
            ],
          ),
          QRoute(
            path: PaymentRouter.storeStats,
            builder: () => store_stats_page.StoreStatsPage(),
            middleware: [
              DeferredLoadingMiddleware(store_stats_page.loadLibrary),
            ],
          ),
        ],
      );
}
