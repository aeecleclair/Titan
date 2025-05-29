import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/providers/manager_booking_list_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, List<StateNotifierProvider>>>
bookingProviders = {
  "userBooking": Tuple2(BookingRouter.root, [
    userBookingListProvider,
    confirmedBookingListProvider,
  ]),
  "bookings": Tuple2(BookingRouter.root + BookingRouter.admin, [
    managerBookingListProvider,
  ]),
};
