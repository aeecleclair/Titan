import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/raffle/providers/is_raffle_admin.dart';
import 'package:myecl/raffle/ui/pages/admin_module_page/admin_module_page.dart'
    deferred as admin_module_page;
import 'package:myecl/raffle/ui/pages/creation_edit_page/creation_edit_page.dart'
    deferred as creation_edit_page;
import 'package:myecl/raffle/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:myecl/raffle/ui/pages/pack_ticket_page/add_edit_pack_ticket_page.dart'
    deferred as add_edit_pack_ticket_page;
import 'package:myecl/raffle/ui/pages/prize_page/add_edit_prize_page.dart'
    deferred as add_edit_prize_page;
import 'package:myecl/raffle/ui/pages/raffle_page/raffle_page.dart'
    deferred as raffle_page;
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RaffleRouter {
  final ProviderRef ref;
  static const String root = '/tombola';
  static const String admin = '/admin';
  static const String detail = '/detail';
  static const String addEditPrize = '/add_edit_prize';
  static const String addEditPackTicket = '/add_edit_pack_ticket';
  static const String creation = '/creation';
  static final Module module = Module(
    name: "Tombola",
    icon: const Left(HeroIcons.gift),
    root: RaffleRouter.root,
    selected: false,
  );
  RaffleRouter(this.ref);
  QRoute route() => QRoute(
        name: "raffle",
        path: RaffleRouter.root,
        builder: () => main_page.RaffleMainPage(),
        middleware: [
          AuthenticatedMiddleware(ref),
          DeferredLoadingMiddleware(main_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: admin,
            builder: () => admin_module_page.AdminModulePage(),
            middleware: [
              AdminMiddleware(ref, isRaffleAdminProvider),
              DeferredLoadingMiddleware(admin_module_page.loadLibrary),
            ],
          ),
          QRoute(
            path: detail,
            builder: () => raffle_page.RaffleInfoPage(),
            middleware: [
              AdminMiddleware(ref, isRaffleAdminProvider),
              DeferredLoadingMiddleware(raffle_page.loadLibrary),
            ],
            children: [
              QRoute(
                path: creation,
                builder: () => creation_edit_page.CreationPage(),
                middleware: [
                  DeferredLoadingMiddleware(creation_edit_page.loadLibrary),
                ],
                children: [
                  QRoute(
                    path: addEditPrize,
                    builder: () => add_edit_prize_page.AddEditPrizePage(),
                    middleware: [
                      DeferredLoadingMiddleware(
                        add_edit_prize_page.loadLibrary,
                      ),
                    ],
                  ),
                  QRoute(
                    path: addEditPackTicket,
                    builder: () =>
                        add_edit_pack_ticket_page.AddEditPackTicketPage(),
                    middleware: [
                      DeferredLoadingMiddleware(
                        add_edit_pack_ticket_page.loadLibrary,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
