import 'package:flutter_riverpod/flutter_riverpod.dart';

final isBookingAdminProvider =
    StateNotifierProvider<IsBookingAdminNotifier, bool>((ref) {
  return IsBookingAdminNotifier();
});

class IsBookingAdminNotifier extends StateNotifier<bool> {
  IsBookingAdminNotifier() : super(true);

  void setIsBookingAdmin(bool i) {
    state = i;
  }
}
