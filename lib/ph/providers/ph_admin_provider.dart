import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/ph/class/ph_admin.dart';
import 'package:myecl/ph/providers/ph_admin_id_provider.dart';
import 'package:myecl/ph/providers/user_ph_admin_list_provider.dart';

final phAdminProvider = Provider((ref) {
  final phAdminId = ref.watch(phAdminIdProvider);
  final phAdminList = ref.watch(userPhAdminListProvider);
  return phAdminList.maybeWhen(
    data: (loanerList) =>
        loanerList.firstWhere((phAdmin) => phAdmin.id == phAdminId),
    orElse: () => PhAdmin.empty(),
  );
});
