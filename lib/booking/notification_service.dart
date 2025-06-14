import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/booking/providers/manager_booking_list_provider.dart';
import 'package:titan/booking/providers/confirmed_booking_list_provider.dart';
import 'package:titan/booking/providers/user_booking_list_provider.dart';
import 'package:titan/booking/router.dart';
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
