import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tombola/providers/is_tombola_admin.dart';
import 'package:myecl/tombola/ui/pages/admin_module_page/admin_module_page.dart';
import 'package:myecl/tombola/ui/pages/creation_edit_page/creation_edit_page.dart';
import 'package:myecl/tombola/ui/pages/main_page/main_page.dart';
import 'package:myecl/tombola/ui/pages/pack_ticket_page/add_edit_pack_ticket_page.dart';
import 'package:myecl/tombola/ui/pages/prize_page/add_edit_prize_page.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/tombola_page.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RaffleRouter {
  final ProviderRef ref;
  static const String root = '/tombola';
  static const String admin = '/admin';
  static const String detail = '/detail';
  static const String addEditLot = '/add_edit_lot';
  static const String addEditPackTicket = '/add_edit_pack_ticket';
  static const String creation = '/creation';
  static final Module module = Module(
      name: "Tombola",
      icon: const Left(HeroIcons.gift),
      root: RaffleRouter.root,
      selected: false);
  RaffleRouter(this.ref);

  QRoute route() => QRoute(
        path: RaffleRouter.root,
        builder: () => const RaffleMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: [
          QRoute(
              path: admin,
              builder: () => const AdminModulePage(),
              middleware: [
                AdminMiddleware(ref, isTombolaAdminProvider),
              ]),
          QRoute(
              path: detail,
              builder: () => const TombolaInfoPage(),
              middleware: [
                AdminMiddleware(ref, isTombolaAdminProvider),
              ],
              children: [
                QRoute(
                    path: creation,
                    builder: () => const CreationPage(),
                    children: [
                      QRoute(
                          path: addEditLot,
                          builder: () => const AddEditLotPage()),
                      QRoute(
                          path: addEditPackTicket,
                          builder: () => const AddEditPackTicketPage()),
                    ]),
              ]),
        ],
      );
}
