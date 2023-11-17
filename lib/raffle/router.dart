import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/raffle/providers/is_raffle_admin.dart';
import 'package:myecl/raffle/ui/pages/admin_module_page/admin_module_page.dart';
import 'package:myecl/raffle/ui/pages/creation_edit_page/creation_edit_page.dart';
import 'package:myecl/raffle/ui/pages/main_page/main_page.dart';
import 'package:myecl/raffle/ui/pages/pack_ticket_page/add_edit_pack_ticket_page.dart';
import 'package:myecl/raffle/ui/pages/prize_page/add_edit_prize_page.dart';
import 'package:myecl/raffle/ui/pages/raffle_page/raffle_page.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RaffleRouter {
  final ProviderRef ref;
  static const String root = '/raffle';
  static const String admin = '/admin';
  static const String detail = '/detail';
  static const String addEditPrize = '/add_edit_prize';
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
                AdminMiddleware(ref, isRaffleAdminProvider),
              ]),
          QRoute(
              path: detail,
              builder: () => const RaffleInfoPage(),
              middleware: [
                AdminMiddleware(ref, isRaffleAdminProvider),
              ],
              children: [
                QRoute(
                    path: creation,
                    builder: () => const CreationPage(),
                    children: [
                      QRoute(
                          path: addEditPrize,
                          builder: () => const AddEditPrizePage()),
                      QRoute(
                          path: addEditPackTicket,
                          builder: () => const AddEditPackTicketPage()),
                    ]),
              ]),
        ],
      );
}
