import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserBookingRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'booking/bookings/users/me';

  Future<List<Booking>> getUserBookingList() async {
    return List<Booking>.from(
        (await getList()).map((x) => Booking.fromJson(x)));
  }
}
