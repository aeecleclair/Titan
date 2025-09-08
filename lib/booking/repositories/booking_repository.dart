import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class BookingRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'booking/bookings';

  Future<List<Booking>> getUserBookingList() async {
    return List<Booking>.from(
      (await getList(suffix: "/users/me")).map((x) => Booking.fromJson(x)),
    );
  }

  Future<List<Booking>> getUserManageBookingList() async {
    return List<Booking>.from(
      (await getList(
        suffix: "/users/me/manage",
      )).map((x) => Booking.fromJson(x)),
    );
  }

  Future<Booking> createBooking(Booking booking) async {
    return Booking.fromJson(await create(booking.toJson()));
  }

  Future<bool> updateBooking(Booking booking) async {
    return await update(booking.toJson(), "/${booking.id}");
  }

  Future<bool> confirmBooking(Booking booking, Decision value) async {
    return await update(
      {},
      "/${booking.id}",
      suffix: '/reply/${value.toString().split('.')[1]}',
    );
  }

  Future<bool> deleteBooking(String bookingId) async {
    return await delete("/$bookingId");
  }

  Future<List<Booking>> getConfirmedBookingList() async {
    return List<Booking>.from(
      (await getList(suffix: "/confirmed")).map((x) => Booking.fromJson(x)),
    );
  }

  Future<List<Booking>> getUserManageConfirmedBookingList() async {
    return List<Booking>.from(
      (await getList(
        suffix: "/confirmed/users/me/manage",
      )).map((x) => Booking.fromJson(x)),
    );
  }
}

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return BookingRepository()..setToken(token);
});
