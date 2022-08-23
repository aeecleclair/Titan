import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/tools/repository/repository.dart';

class BookingRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'bdebooking/bookings';

  Future<List<Booking>> getBookingList() async {
    return List<Booking>.from(
        (await getList()).map((x) => Booking.fromJson(x)));
  }

  Future<Booking> createBooking(Booking booking) async {
    return Booking.fromJson(await create(booking.toJson()));
  }

  Future<bool> updateBooking(Booking booking) async {
    return await update(booking.toJson(), booking.id);
  }

  Future<bool> confirmBooking(Booking booking, bool value) async {
    return await update({}, booking.id, suffix: '/confirm/' + value.toString());
  }

  Future<bool> deleteBooking(String bookingId) async {
    return await delete(bookingId);
  }

  Future<List<Booking>> getHistoryBookingList() async {
    return List<Booking>.from(
        (await getList(suffix: '/history')).map((x) => Booking.fromJson(x)));
  }
}
