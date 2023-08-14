import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/booking/ui/pages/main_page/main_page.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CentralisationRouter {
  final ProviderRef ref;
  static const String root = '/centralisation';
  static final Module module = Module(
      name: "Réservation",
      icon: const Left(HeroIcons.tableCells),
      root: CentralisationRouter.root,
      selected: false);
  CentralisationRouter(this.ref);

  QRoute route() => QRoute(
        path: CentralisationRouter.root,
        builder: () => const BookingMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
      );
}
