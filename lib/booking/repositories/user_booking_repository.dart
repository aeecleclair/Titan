import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserBookingRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'booking/bookings/user/';

  Future<List<Booking>> getMyBookingList(String userId) async {
    return List<Booking>.from(
        (await getList(suffix: userId)).map((x) => Booking.fromJson(x)));
  }
}
