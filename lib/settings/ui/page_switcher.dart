import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/settings/providers/settings_page_provider.dart';
import 'package:myecl/settings/ui/pages/change_pass/change_pass.dart';
import 'package:myecl/settings/ui/pages/edit_user_page/edit_user_page.dart';
import 'package:myecl/settings/ui/pages/main_page/main_page.dart';
import 'package:myecl/settings/ui/pages/notification_page/notification_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(settingsPageProvider);
    switch (page) {
      case SettingsPage.main:
        return const MainPage();
      case SettingsPage.info:
        return const EditUserPage();
      case SettingsPage.security:
        return const ChangePassPage();
      case SettingsPage.notification:
        return const NotificationPage();
    }
  }
}
