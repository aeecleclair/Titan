import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/booking/providers/is_admin_provider.dart';
import 'package:myecl/booking/providers/is_manager_provider.dart';
import 'package:myecl/booking/ui/pages/admin_pages/add_edit_manager_page.dart';
import 'package:myecl/booking/ui/pages/detail_pages/detail_booking.dart';
import 'package:myecl/booking/ui/pages/admin_pages/admin_page.dart';
import 'package:myecl/booking/ui/pages/booking_pages/add_edit_booking_page.dart';
import 'package:myecl/booking/ui/pages/main_page/main_page.dart';
import 'package:myecl/booking/ui/pages/manager_page/manager_page.dart';
import 'package:myecl/booking/ui/pages/admin_pages/add_edit_room_page.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class BookingRouter {
  final ProviderRef ref;
  static const String root = '/booking';
  static const String admin = '/admin';
  static const String manager = '/manager';
  static const String addEdit = '/add_edit';
  static const String detail = '/detail';
  static const String room = '/room';
  static final Module module = Module(
      name: "Réservation",
      icon: const Left(HeroIcons.tableCells),
      root: BookingRouter.root,
      selected: false);
  BookingRouter(this.ref);

  QRoute route() => QRoute(
        path: BookingRouter.root,
        builder: () => const BookingMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: [
          QRoute(
            path: admin,
            builder: () => const AdminPage(),
            middleware: [AdminMiddleware(ref, isAdminProvider)],
            children: [
              QRoute(
                path: room,
                builder: () => AddEditRoomPage(),
                middleware: [AdminMiddleware(ref, isAdminProvider)],
              ),
              QRoute(
                path: manager,
                builder: () => AddEditManagerPage(),
                middleware: [AdminMiddleware(ref, isAdminProvider)],
              )
            ],
          ),
          QRoute(
            path: manager,
            builder: () => const ManagerPage(),
            middleware: [AdminMiddleware(ref, isManagerProvider)],
            children: [
              QRoute(
                  path: detail,
                  builder: () => const DetailBookingPage(isAdmin: true),
                  middleware: [
                    AdminMiddleware(ref, isManagerProvider),
                  ]),
              QRoute(
                path: addEdit,
                builder: () => const AddEditBookingPage(isAdmin: true),
                middleware: [AdminMiddleware(ref, isManagerProvider)],
              ),
            ],
          ),
          QRoute(
            path: addEdit,
            builder: () => const AddEditBookingPage(isAdmin: false),
          ),
          QRoute(
            path: detail,
            builder: () => const DetailBookingPage(isAdmin: false),
          ),
        ],
      );
}
