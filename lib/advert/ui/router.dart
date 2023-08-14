import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/admin/providers/is_admin.dart';
import 'package:myecl/advert/providers/is_advert_admin_provider.dart';
import 'package:myecl/advert/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/advert/ui/pages/detail_page/detail.dart';
import 'package:myecl/advert/ui/pages/form_page/add_edit_advert_page.dart';
import 'package:myecl/advert/ui/pages/form_page/add_rem_announcer_page.dart';
import 'package:myecl/advert/ui/pages/main_page/main_page.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdvertRouter {
  final ProviderRef ref;
  static const String root = '/advert';
  static const String admin = '/admin';
  static const String addEditAdvert = '/add_edit_advert';
  static const String addRemAnnoucer = '/add_rem_announcer';
  static const String detail = '/detail';
  static final Module module = Module(
      name: "Annonce",
      icon: const Left(HeroIcons.megaphone),
      root: AdvertRouter.root,
      selected: false);
  AdvertRouter(this.ref);

  QRoute route() => QRoute(
        path: AdvertRouter.root,
        builder: () => const AdvertMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: [
          QRoute(
              path: admin,
              builder: () => const AdvertAdminPage(),
              middleware: [
                AdminMiddleware(ref, isAdvertAdminProvider),
              ],
              children: [
                QRoute(
                    path: addEditAdvert,
                    builder: () => const AdvertAddEditAdvertPage()),
              ]),
          QRoute(path: detail, builder: () => const AdvertDetailPage()),
          QRoute(
            path: addRemAnnoucer,
            builder: () => const AddRemAnnouncerPage(),
            middleware: [
              AdminMiddleware(ref, isAdminProvider),
            ],
          ),
        ],
      );
}
