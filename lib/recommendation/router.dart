import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/recommendation/providers/is_recommendation_admin_provider.dart';
import 'package:titan/recommendation/ui/pages/main_page.dart'
    deferred as main_page;
import 'package:titan/recommendation/ui/pages/information_page.dart'
    deferred as information_page;
import 'package:titan/recommendation/ui/pages/add_edit_page.dart'
    deferred as add_edit_page;
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RecommendationRouter {
  final Ref ref;

  static const String root = '/recommendation';
  static const String information = '/information';
  static const String addEdit = '/add_edit';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.moduleRecommendation,
    getDescription: (context) =>
        AppLocalizations.of(context)!.moduleRecommendationDescription,
    root: RecommendationRouter.root,
  );

  RecommendationRouter(this.ref);

  QRoute route() => QRoute(
    name: "recommendation",
    path: RecommendationRouter.root,
    builder: () => main_page.RecommendationMainPage(),
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
        path: information,
        builder: () => information_page.InformationRecommendationPage(),
        middleware: [DeferredLoadingMiddleware(information_page.loadLibrary)],
      ),
      QRoute(
        path: addEdit,
        builder: () => add_edit_page.AddEditRecommendationPage(),
        middleware: [
          AdminMiddleware(ref, isRecommendationAdminProvider),
          DeferredLoadingMiddleware(add_edit_page.loadLibrary),
        ],
      ),
    ],
  );
}
