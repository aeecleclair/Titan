import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/services/booking_notification.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserBookingRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'bdebooking/user/';
  final BookingNotification bookingNotification = BookingNotification()..init();

  Future<List<Booking>> getMyBookingList(String userId) async {
    final List<Booking> bookingList = List<Booking>.from(
        (await getList(suffix: userId)).map((x) => Booking.fromJson(x)));
    bookingNotification.scheduleAllSession(bookingList);
    return bookingList;
  }
}
