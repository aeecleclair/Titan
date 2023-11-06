import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/raffle/providers/is_raffle_admin.dart';
import 'package:myecl/raffle/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/raffle/ui/pages/lots_pages/add_edit_prize_page.dart';
import 'package:myecl/raffle/ui/pages/main_page/main_page.dart';
import 'package:myecl/raffle/ui/pages/pack_ticket_page/add_edit_pack_ticket_page.dart';
import 'package:myecl/raffle/ui/pages/raffle_page/tombola_page.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RaffleRouter {
  final ProviderRef ref;
  static const String root = '/raffle';
  static const String admin = '/admin';
  static const String addEditPrize = '/add_edit_lot';
  static const String addEditTypeTicket = '/add_edit_type_ticket';
  static const String raffle = '/tombola';
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
          QRoute(path: admin, builder: () => const AdminPage(), middleware: [
            AdminMiddleware(ref, isRaffleAdminProvider),
          ], children: [
            QRoute(path: addEditPrize, builder: () => const AddEditPrizePage()),
            QRoute(
                path: addEditTypeTicket,
                builder: () => const AddEditPackTicketPage()),
          ]),
          QRoute(path: raffle, builder: () => const RaffleInfoPage()),
        ],
      );
}
