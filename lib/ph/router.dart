// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/ph/providers/is_ph_admin_provider.dart';
import 'package:titan/ph/ui/pages/form_page/add_edit_ph_page.dart'
    deferred as add_edit_ph_page;
import 'package:titan/ph/ui/pages/past_ph_selection_page/past_ph_selection_page.dart';
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/ph/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/ph/ui/pages/admin_page/admin_page.dart'
    deferred as admin_page;
import 'package:titan/ph/ui/pages/view_ph/view_ph.dart'
    deferred as view_ph_page;

class PhRouter {
  final Ref ref;
  static const String root = '/ph';
  static const String past_ph_selection = '/past_ph_selection';
  static const String view_ph = '/view_ph';
  static const String admin = '/admin';
  static const String add_ph = '/add_ph';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.modulePh,
    getDescription: (context) =>
        AppLocalizations.of(context)!.modulePhDescription,
    root: PhRouter.root,
  );
  PhRouter(this.ref);
  QRoute route() => QRoute(
    name: "ph",
    path: PhRouter.root,
    builder: () => main_page.PhMainPage(),
    middleware: [DeferredLoadingMiddleware(main_page.loadLibrary)],
    pageType: QCustomPage(
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
    children: [
      QRoute(
        path: past_ph_selection,
        builder: () => const PastPhSelectionPage(),
        children: [
          QRoute(
            path: view_ph,
            builder: () => view_ph_page.ViewPhPage(),
            middleware: [DeferredLoadingMiddleware(view_ph_page.loadLibrary)],
          ),
        ],
      ),
      QRoute(
        path: admin,
        builder: () => admin_page.AdminPage(),
        middleware: [
          AdminMiddleware(ref, isPhAdminProvider),
          DeferredLoadingMiddleware(admin_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: add_ph,
            builder: () => add_edit_ph_page.PhAddEditPhPage(),
            middleware: [
              DeferredLoadingMiddleware(add_edit_ph_page.loadLibrary),
            ],
          ),
        ],
      ),
    ],
  );
}
