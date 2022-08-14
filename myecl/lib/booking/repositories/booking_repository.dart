import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/tools/repository/repository.dart';

class BookingRepository extends Repository {
  @override
  final ext = 'bdebooking/bookings';

  Future<List<Booking>> getBookingList() async {
    return List<Booking>.from((await getList()).map((x) => Booking.fromJson(x)));
  }

  Future<Booking> createBooking(Booking booking) async {
    return Booking.fromJson(await create(booking.toJson()));
  }

  Future<bool> updateBooking(Booking booking) async {
    return await update(booking.toJson(), booking.id);
  }

  Future<bool> deleteBooking(String bookingId) async {
    return await delete(bookingId);
  }

  Future<List<Booking>> getHistoryBookingList() async {
    return List<Booking>.from((await getList(suffix: '/history')).map((x) => Booking.fromJson(x)));
  }
}
