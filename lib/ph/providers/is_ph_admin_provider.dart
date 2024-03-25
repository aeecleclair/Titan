import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/ph/providers/user_ph_admin_list_provider.dart';

final isPhAdminProvider = StateProvider<bool>((ref) {
  final phAdmins = ref.watch(userPhAdminListProvider);
  final phAdminsName = phAdmins.maybeWhen(
      data: (phAdmins) => phAdmins.map((e) => e.name).toList(),
      orElse: () => []);
  return phAdminsName.isNotEmpty;
});
