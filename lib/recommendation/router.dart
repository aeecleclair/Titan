import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/recommendation/providers/is_recommendation_admin_provider.dart';
import 'package:myecl/recommendation/ui/pages/main_page.dart'
    deferred as main_page;
import 'package:myecl/recommendation/ui/pages/information_page.dart'
    deferred as information_page;
import 'package:myecl/recommendation/ui/pages/add_edit_page.dart'
    deferred as add_edit_page;
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RecommendationRouter {
  final ProviderRef ref;

  static const String root = '/recommendation';
  static const String information = '/information';
  static const String addEdit = '/add_edit';
  static final Module module = Module(
    name: "Bons plans",
    icon: const Left(HeroIcons.newspaper),
    root: RecommendationRouter.root,
    selected: false,
  );

  RecommendationRouter(this.ref);

  QRoute route() => QRoute(
        path: RecommendationRouter.root,
        builder: () => main_page.RecommendationMainPage(),
        middleware: [
          AuthenticatedMiddleware(ref),
          DeferredLoadingMiddleware(main_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: information,
            builder: () => information_page.InformationRecommendationPage(),
            middleware: [
              DeferredLoadingMiddleware(information_page.loadLibrary)
            ],
          ),
          QRoute(
            path: addEdit,
            builder: () => add_edit_page.AddEditRecommendationPage(),
            middleware: [
              AdminMiddleware(ref, isRecommendationAdminProvider),
              DeferredLoadingMiddleware(add_edit_page.loadLibrary)
            ],
          ),
        ],
      );
}
