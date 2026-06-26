import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/booking/providers/is_admin_provider.dart';
import 'package:titan/booking/providers/is_manager_provider.dart';
import 'package:titan/booking/ui/pages/admin_pages/add_edit_manager_page.dart'
    deferred as add_edit_manager_page;
import 'package:titan/booking/ui/pages/detail_pages/detail_booking.dart'
    deferred as detail_booking_page;
import 'package:titan/booking/ui/pages/admin_pages/admin_page.dart'
    deferred as admin_page;
import 'package:titan/booking/ui/pages/booking_pages/add_edit_booking_page.dart'
    deferred as add_edit_booking_page;
import 'package:titan/booking/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/booking/ui/pages/manager_page/manager_page.dart'
    deferred as manager_page;
import 'package:titan/booking/ui/pages/admin_pages/add_edit_room_page.dart'
    deferred as add_edit_room_page;
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class BookingRouter {
  final Ref ref;
  static const String root = '/booking';
  static const String admin = '/admin';
  static const String manager = '/manager';
  static const String addEdit = '/add_edit';
  static const String detail = '/detail';
  static const String room = '/room';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.moduleBooking,
    getDescription: (context) =>
        AppLocalizations.of(context)!.moduleBookingDescription,
    root: BookingRouter.root,
  );
  BookingRouter(this.ref);

  QRoute route() => QRoute(
    name: "booking",
    path: BookingRouter.root,
    builder: () => main_page.BookingMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    pageType: QCustomPage(
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
    children: [
      QRoute(
        path: admin,
        builder: () => admin_page.AdminPage(),
        middleware: [
          AdminMiddleware(ref, isAdminProvider),
          DeferredLoadingMiddleware(admin_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: room,
            builder: () => add_edit_room_page.AddEditRoomPage(),
            middleware: [
              AdminMiddleware(ref, isAdminProvider),
              DeferredLoadingMiddleware(add_edit_room_page.loadLibrary),
            ],
          ),
          QRoute(
            path: manager,
            builder: () => add_edit_manager_page.AddEditManagerPage(),
            middleware: [
              AdminMiddleware(ref, isAdminProvider),
              DeferredLoadingMiddleware(add_edit_manager_page.loadLibrary),
            ],
          ),
        ],
      ),
      QRoute(
        path: manager,
        builder: () => manager_page.ManagerPage(),
        middleware: [
          AdminMiddleware(ref, isManagerProvider),
          DeferredLoadingMiddleware(manager_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: detail,
            builder: () => detail_booking_page.DetailBookingPage(isAdmin: true),
            middleware: [
              AdminMiddleware(ref, isManagerProvider),
              DeferredLoadingMiddleware(detail_booking_page.loadLibrary),
            ],
          ),
          QRoute(
            path: addEdit,
            builder: () =>
                add_edit_booking_page.AddEditBookingPage(isManagerPage: true),
            middleware: [
              AdminMiddleware(ref, isManagerProvider),
              DeferredLoadingMiddleware(add_edit_booking_page.loadLibrary),
            ],
          ),
        ],
      ),
      QRoute(
        path: addEdit,
        builder: () =>
            add_edit_booking_page.AddEditBookingPage(isManagerPage: false),
        middleware: [
          DeferredLoadingMiddleware(add_edit_booking_page.loadLibrary),
        ],
      ),
      QRoute(
        path: detail,
        builder: () => detail_booking_page.DetailBookingPage(isAdmin: false),
        middleware: [
          DeferredLoadingMiddleware(detail_booking_page.loadLibrary),
        ],
      ),
    ],
  );
}
