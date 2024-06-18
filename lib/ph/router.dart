// ignore_for_file: constant_identifier_names

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/ph/ui/pages/form_page/add_edit_ph_page.dart'
    deferred as add_edit_ph_page;
import 'package:myecl/ph/ui/pages/past_ph_selection_page/past_ph_selection_page.dart'
    deferred as past_ph_selection_page;
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/ph/ui/pages/admin_page/admin_page.dart'
    deferred as admin_page;

class PhRouter {
  final ProviderRef ref;
  static const String root = '/ph';
  static const String past_ph_selection = '/past_ph_selection';
  static const String view_ph = '/view_ph';
  static const String admin = '/admin';
  static const String add_ph = '/add_ph';
  static final Module module = Module(
    name: "PH",
    icon: const Left(HeroIcons.newspaper),
    root: PhRouter.root,
    selected: false,
  );
  PhRouter(this.ref);
  QRoute route() => QRoute(
        name: "ph",
        path: PhRouter.root,
        builder: () => past_ph_selection_page.PastPhSelectionPage(),
        middleware: [
          DeferredLoadingMiddleware(past_ph_selection_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: admin,
            builder: () => admin_page.AdminPage(),
            middleware: [
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
