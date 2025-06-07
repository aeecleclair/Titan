import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/admin/providers/is_admin_provider.dart';
import 'package:myecl/advert/providers/is_advert_admin_provider.dart';
import 'package:myecl/advert/ui/pages/admin_page/admin_page.dart'
    deferred as admin_page;
import 'package:myecl/advert/ui/pages/detail_page/detail.dart'
    deferred as detail_page;
import 'package:myecl/advert/ui/pages/form_page/add_edit_advert_page.dart'
    deferred as add_edit_advert_page;
import 'package:myecl/advert/ui/pages/form_page/add_rem_announcer_page.dart'
    deferred as add_rem_announcer_page;
import 'package:myecl/advert/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdvertRouter {
  final Ref ref;
  static const String root = '/advert';
  static const String admin = '/admin';
  static const String addEditAdvert = '/add_edit_advert';
  static const String addRemAnnouncer = '/add_remove_announcer';
  static const String detail = '/:advertId';
  static final Module module = Module(
    name: "Annonce",
    icon: const Left(HeroIcons.megaphone),
    root: AdvertRouter.root,
    selected: false,
  );
  AdvertRouter(this.ref);

  QRoute route() => QRoute(
    name: "advert",
    path: AdvertRouter.root,
    builder: () => main_page.AdvertMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    children: [
      QRoute(
        path: admin,
        builder: () => admin_page.AdvertAdminPage(),
        middleware: [
          AdminMiddleware(ref, isAdvertAdminProvider),
          DeferredLoadingMiddleware(admin_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: addEditAdvert,
            builder: () => add_edit_advert_page.AdvertAddEditAdvertPage(),
            middleware: [
              DeferredLoadingMiddleware(add_edit_advert_page.loadLibrary),
            ],
          ),
        ],
      ),
      QRoute(
        path: detail,
        builder: () => detail_page.AdvertDetailPage(),
        middleware: [DeferredLoadingMiddleware(detail_page.loadLibrary)],
      ),
      QRoute(
        path: addRemAnnouncer,
        builder: () => add_rem_announcer_page.AddRemAnnouncerPage(),
        middleware: [
          AdminMiddleware(ref, isAdminProvider),
          DeferredLoadingMiddleware(add_rem_announcer_page.loadLibrary),
        ],
      ),
    ],
  );
}
