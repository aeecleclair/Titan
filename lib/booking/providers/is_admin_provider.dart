import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/booking/providers/user_manager_list_provider.dart';
import 'package:titan/booking/tools/constants.dart';
import 'package:titan/tools/functions.dart';

final isManagersAdminProvider = Provider<bool>((ref) {
  return hasUserPermission(ref, BookingPermissionConstants.manageManagers);
});

final isRoomsAdminProvider = Provider<bool>((ref) {
  return hasUserPermission(ref, BookingPermissionConstants.manageRooms);
});

final isBookingAdminProvider = Provider<bool>((ref) {
  final isManagersAdmin = ref.watch(isManagersAdminProvider);
  final isRoomsAdmin = ref.watch(isRoomsAdminProvider);
  return isManagersAdmin || isRoomsAdmin;
});

final isManagerProvider = StateProvider<bool>((ref) {
  final managers = ref.watch(userManagerListProvider);
  final managersName = managers.when(
    data: (managers) => managers.map((e) => e.name).toList(),
    loading: () => [],
    error: (error, stackTrace) => [],
  );
  return managersName.isNotEmpty;
});
