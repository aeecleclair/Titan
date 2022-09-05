import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/settings/providers/settings_page_provider.dart';
import 'package:myecl/settings/ui/pages/info_page/info_page.dart';
import 'package:myecl/settings/ui/pages/main_page/main_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(settingsPageProvider);
    switch (page) {
      case SettingsPage.main:
        return const MainPage();
      case SettingsPage.info:
        return const InfoPage();
    }
  }
}
