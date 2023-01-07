import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/home/providers/theme_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/ui/pages/main_page/settings_item.dart';

class DarkModeItem extends HookConsumerWidget {
  const DarkModeItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);
    final isDarkThemeNotifier = ref.watch(isDarkThemeProvider.notifier);
    return SettingsItem(
      icon: isDarkTheme ? HeroIcons.moon : HeroIcons.sun,
      onTap: () {
        isDarkThemeNotifier.toggle();
        isDarkThemeNotifier.saveToPrefs();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(SettingsTextConstants.darkMode,
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.tertiary)),
          Text(
              isDarkTheme
                  ? SettingsTextConstants.darkModeOn
                  : SettingsTextConstants.darkModeOff,
              style: TextStyle(
                  fontSize: 12, color: Theme.of(context).colorScheme.tertiary)),
        ],
      ),
    );
  }
}
