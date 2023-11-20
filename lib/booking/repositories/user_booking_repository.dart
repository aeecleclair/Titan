import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserBookingRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'booking/bookings/users/';

  Future<List<Booking>> getMyBookingList(String userId) async {
    return List<Booking>.from(
        (await getList(suffix: userId)).map((x) => Booking.fromJson(x)));
  }
}

final userBookingRepositoryProvider = Provider<UserBookingRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return UserBookingRepository()..setToken(token);
});
