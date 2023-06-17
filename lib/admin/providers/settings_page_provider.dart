import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AdminPage { main, addAsso, edit, addLoaner }

final adminPageProvider =
    StateNotifierProvider<AdminPageNotifier, AdminPage>((ref) {
  return AdminPageNotifier();
});

class AdminPageNotifier extends StateNotifier<AdminPage> {
  AdminPageNotifier() : super(AdminPage.main);

  void setAdminPage(AdminPage i) {
    state = i;
  }
}
