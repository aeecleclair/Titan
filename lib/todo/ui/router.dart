import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TodoRouter {
  final ProviderRef ref;
  static const String root = '/todo';
  static const String addEdit = '/add_edit_todo';
  static final Module module = Module(
      name: "Todo",
      icon: const Left(HeroIcons.check),
      root: TodoRouter.root,
      selected: false);
  TodoRouter(this.ref);

  QRoute route() => QRoute(
        path: TodoRouter.root,
        builder: () => const TodoMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        // children: [
        //   QRoute(path: addEdit, builder: () => const AddEditLotPage()),
        // ],
      );
}
