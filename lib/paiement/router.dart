import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/paiement/ui/pages/devices_page/devices_page.dart'
    deferred as devices_page;
import 'package:myecl/paiement/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:myecl/paiement/ui/pages/stats_page/stats_page.dart'
    deferred as stats_page;
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PaymentRouter {
  final ProviderRef ref;
  static const String root = '/payment';
  static const String stats = '/stats';
  static const String devices = '/devices';
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
        ],
      );
}
