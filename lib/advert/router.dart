import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:titan/advert/ui/pages/admin_page/admin_page.dart'
    deferred as admin_page;
import 'package:titan/advert/ui/pages/form_page/add_edit_advert_page.dart'
    deferred as add_edit_advert_page;
import 'package:titan/advert/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/feed/providers/is_user_a_member_of_an_association.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdvertRouter {
  final Ref ref;
  static const String root = '/advert';
  static const String admin = '/admin';
  static const String addEditAdvert = '/add_edit_advert';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.moduleAdvert,
    getDescription: (context) =>
        AppLocalizations.of(context)!.moduleAdvertDescription,
    root: AdvertRouter.root,
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
    pageType: QCustomPage(
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
    children: [
      QRoute(
        path: admin,
        builder: () => admin_page.AdvertAdminPage(),
        middleware: [
          AdminMiddleware(ref, isUserAMemberOfAnAssociationProvider),
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
    ],
  );
}
