import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/middlewares/booking_admin_middleware.dart';
import 'package:myecl/booking/ui/pages/detail_pages/detail_booking.dart';
import 'package:myecl/booking/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/booking/ui/pages/booking_pages/add_edit_booking_page.dart';
import 'package:myecl/booking/ui/pages/main_page/main_page.dart';
import 'package:myecl/booking/ui/pages/room_pages/add_edit_room_page.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class BookingRouter {
  final ProviderRef ref;
  static const String root = '/booking';
  static const String admin = '/admin';
  static const String addEdit = '/add_edit';
  static const String detail = '/detail';
  static const String room = '/room';
  BookingRouter(this.ref);

  QRoute route() => QRoute(
        path: BookingRouter.root,
        builder: () => const BookingMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: [
          QRoute(path: admin, builder: () => const AdminPage(), middleware: [
            BookingAdminMiddleware(ref),
          ], children: [
            QRoute(
                path: detail,
                builder: () => const DetailBookingPage(isAdmin: true)),
            QRoute(
                path: addEdit,
                builder: () => const AddEditBookingPage(isAdmin: true)),
            QRoute(path: room, builder: () => const AddEditRoomPage()),
          ]),
          QRoute(
              path: addEdit,
              builder: () => const AddEditBookingPage(isAdmin: false)),
          QRoute(
              path: detail,
              builder: () => const DetailBookingPage(isAdmin: false)),
        ],
      );
}
