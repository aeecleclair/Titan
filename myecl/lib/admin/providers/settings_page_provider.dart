import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AdminPage { main, asso, addAsso, addMember, edit }


final adminPageProvider = StateNotifierProvider<SettingsPageNotifier, AdminPage>((ref) {
  return SettingsPageNotifier();
});

class SettingsPageNotifier extends StateNotifier<AdminPage> {
  SettingsPageNotifier() : super(AdminPage.main);

  void setSettingsPage(AdminPage i) {
    state = i;
  }
}