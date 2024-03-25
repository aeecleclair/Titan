import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/ph/providers/user_ph_admin_list_provider.dart';

final phAdminIdProvider =
    StateNotifierProvider<PhAdminIdProvider, String>((ref) {
  final deliveries = ref.watch(phAdminList);
  if (deliveries.isEmpty) {
    return PhAdminIdProvider("");
  }
  return PhAdminIdProvider("");
});

class PhAdminIdProvider extends StateNotifier<String> {
  PhAdminIdProvider(super.id);

  void setId(String i) {
    state = i;
  }
}
