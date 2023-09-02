import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayedNotificationPopupNotifier extends StateNotifier<bool> {
  DisplayedNotificationPopupNotifier() : super(false) {
    SharedPreferences.getInstance().then((prefs) {
      if (!prefs.containsKey('notificationPopupDisplayed')) {
        state = true;
      }
    });
  }

  void setDisplay() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('notificationPopupDisplayed', true);
    });
    state = false;
  }
}

final displayNotificationPopupProvider =
    StateNotifierProvider<DisplayedNotificationPopupNotifier, bool>((ref) {
  return DisplayedNotificationPopupNotifier();
});
