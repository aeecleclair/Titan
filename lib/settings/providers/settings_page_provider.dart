import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SettingsPage { main, edit, changePassword, notification, logs }


final settingsPageProvider = StateNotifierProvider<SettingsPageNotifier, SettingsPage>((ref) {
  return SettingsPageNotifier();
});

class SettingsPageNotifier extends StateNotifier<SettingsPage> {
  SettingsPageNotifier() : super(SettingsPage.main);

  void setSettingsPage(SettingsPage i) {
    state = i;
  }
}