import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/drawer/class/module.dart';
import 'package:titan/todo/ui/add_edit_page/add_edit_page.dart'
    deferred as add_edit_page;
import 'package:titan/todo/ui/main_page/main_page.dart' deferred as main_page;
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TodoRouter {
  final Ref ref;

  static const String root = '/todo';
  static const String addEdit = '/add_edit';
  static final Module module = Module(
    name: "Todo",
    icon: const Left(HeroIcons.listBullet),
    root: TodoRouter.root,
    selected: false,
  );

  TodoRouter(this.ref);

  QRoute route() => QRoute(
    name: "Todo",
    path: TodoRouter.root,
    builder: () => main_page.TodoMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    children: [
      QRoute(
        path: addEdit,
        builder: () => add_edit_page.TodoAddEditPage(),
        middleware: [DeferredLoadingMiddleware(add_edit_page.loadLibrary)],
      ),
    ],
  );
}
