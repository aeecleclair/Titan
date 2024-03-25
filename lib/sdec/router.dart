import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/sdec/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:myecl/sdec/ui/pages/main_page/second_page.dart'
    deferred as second_page;
import 'package:myecl/sdec/ui/pages/presentation_page/text.dart'
    deferred as presentation_page;
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SdecRouter {
  final ProviderRef ref;
  static const String root = '/sdec';
  static const String presentation = '/presentation';
  static const String description = '/description';
  static final Module module = Module(
      name: "SDeC",
      icon: const Left(HeroIcons.ticket),
      root: SdecRouter.root,
      selected: false);
  SdecRouter(this.ref);

  QRoute route() => QRoute(
          name: "sdec",
          path: SdecRouter.root,
          builder: () => main_page.SdecMainPage(),
          middleware: [
            AuthenticatedMiddleware(ref),
            DeferredLoadingMiddleware(main_page.loadLibrary)
          ],
          children: [
            QRoute(
              path: presentation,
              builder: () => presentation_page.PresentationPage(),
              middleware: [
                DeferredLoadingMiddleware(presentation_page.loadLibrary)
              ],
            ),
            QRoute(
                path: description,
                builder: () => second_page.DescriptionPage(),
                middleware: [
                  DeferredLoadingMiddleware(second_page.loadLibrary)
                ])
          ]);
}
