import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tricount/ui/pages/detail_page/detail_page.dart';
import 'package:myecl/tricount/ui/pages/main_page/main_page.dart';
import 'package:myecl/tricount/ui/pages/sharer_group_page/add_edit_sharer_group_page.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TricountRouter {
  final ProviderRef ref;
  static const String root = '/tricount';
  static const String detail = '/detail';
  static const String addEdit = '/add_edit';
  static final Module module = Module(
      name: "Tricount",
      icon: const Left(HeroIcons.scale),
      root: TricountRouter.root,
      selected: false);
  TricountRouter(this.ref);

  QRoute route() => QRoute(
        path: TricountRouter.root,
        builder: () => const TricountMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: [
          QRoute(path: detail, builder: () => const SharerGroupDetailPage()),
          QRoute(path: addEdit, builder: () => const AddEditSharerGroupPage()),
        ],
      );
}
