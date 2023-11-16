import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/event/ui/pages/detail_page/detail_page.dart';
import 'package:myecl/home/ui/home.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class HomeRouter {
  final ProviderRef ref;
  static const String root = '/home';
  static const String detail = '/detail';
  static final Module module = Module(
      name: "Calendrier",
      icon: const Left(HeroIcons.calendarDays),
      root: HomeRouter.root,
      selected: false);
  HomeRouter(this.ref);

  QRoute route() => QRoute(
          path: HomeRouter.root,
          builder: () => const HomePage(),
          middleware: [
            AuthenticatedMiddleware(ref)
          ],
          children: [
            QRoute(
                path: detail, builder: () => const DetailPage(isAdmin: false)),
          ]);
}
