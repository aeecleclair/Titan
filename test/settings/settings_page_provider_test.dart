// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/settings/providers/settings_page_provider.dart';

void main() {
  group('SettingsPageNotifier', () {
    test('initial state is SettingsPage.main', () {
      final notifier = SettingsPageNotifier();
      expect(notifier.state, SettingsPage.main);
    });

    test('setSettingsPage changes state', () {
      final notifier = SettingsPageNotifier();
      notifier.setSettingsPage(SettingsPage.edit);
      expect(notifier.state, SettingsPage.edit);
    });
  });
}
