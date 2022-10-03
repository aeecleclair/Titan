import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SettingsPage { main, info, changePass }


final settingsPageProvider = StateNotifierProvider<SettingsPageNotifier, SettingsPage>((ref) {
  return SettingsPageNotifier();
});

class SettingsPageNotifier extends StateNotifier<SettingsPage> {
  SettingsPageNotifier() : super(SettingsPage.info);

  void setSettingsPage(SettingsPage i) {
    state = i;
  }
}