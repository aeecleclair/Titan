import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/providers/is_booking_admin_provider.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class BookingAdminMiddleware extends QMiddleware {
  final ProviderRef ref;

  BookingAdminMiddleware(this.ref);

  @override
  Future<String?> redirectGuard(String path) async {
    final isAdmin = ref.watch(isBookingAdminProvider);
    if (isAdmin) {
      return null;
    } else {
      ref.read(pathForwardingProvider.notifier).forward(BookingRouter.root);
      return BookingRouter.root;
    }
  }
}
