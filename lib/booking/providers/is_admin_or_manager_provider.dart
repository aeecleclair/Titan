import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/providers/is_admin_provider.dart';
import 'package:myecl/booking/providers/is_manager_provider.dart';

final isManagerOrAdminProvider = StateProvider<bool>((ref) {
  final isManager = ref.watch(isManagerProvider);
  final isAdmin = ref.watch(isAdminProvider);
  return isManager || isAdmin;
});
