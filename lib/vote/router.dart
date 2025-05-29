import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:myecl/vote/providers/is_vote_admin_provider.dart';
import 'package:myecl/vote/ui/pages/admin_page/admin_page.dart'
    deferred as admin_page;
import 'package:myecl/vote/ui/pages/detail_page/detail_page.dart'
    deferred as detail_page;
import 'package:myecl/vote/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:myecl/vote/ui/pages/contender_pages/add_edit_contender.dart'
    deferred as add_edit_contender;
import 'package:myecl/vote/ui/pages/section_pages/add_section.dart'
    deferred as add_section;
import 'package:qlevar_router/qlevar_router.dart';

class VoteRouter {
  final Ref ref;
  static const String root = '/vote';
  static const String admin = '/admin';
  static const String addEditContender = '/add_edit_contender';
  static const String addSection = '/add_edit_section';
  static const String detail = '/detail';
  static final Module module = Module(
    name: "Vote",
    icon: const Left(HeroIcons.envelopeOpen),
    root: VoteRouter.root,
    selected: false,
  );
  VoteRouter(this.ref);

  QRoute route() => QRoute(
    name: "vote",
    path: VoteRouter.root,
    builder: () => main_page.VoteMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    children: [
      QRoute(
        path: admin,
        builder: () => admin_page.AdminPage(),
        middleware: [
          AdminMiddleware(ref, isVoteAdminProvider),
          DeferredLoadingMiddleware(admin_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: detail,
            builder: () => detail_page.DetailPage(),
            middleware: [DeferredLoadingMiddleware(detail_page.loadLibrary)],
          ),
          QRoute(
            path: addEditContender,
            builder: () => add_edit_contender.AddEditContenderPage(),
            middleware: [
              DeferredLoadingMiddleware(add_edit_contender.loadLibrary),
            ],
          ),
          QRoute(
            path: addSection,
            builder: () => add_section.AddSectionPage(),
            middleware: [DeferredLoadingMiddleware(add_section.loadLibrary)],
          ),
        ],
      ),
      QRoute(
        path: detail,
        builder: () => detail_page.DetailPage(),
        middleware: [DeferredLoadingMiddleware(detail_page.loadLibrary)],
      ),
    ],
  );
}
