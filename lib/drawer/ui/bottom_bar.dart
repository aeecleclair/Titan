import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/providers/display_quit_popup.dart';
import 'package:myecl/drawer/providers/theme_provider.dart';
import 'package:myecl/drawer/tools/constants.dart';

class BottomBar extends HookConsumerWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayQuitNotifier = ref.watch(displayQuitProvider.notifier);
    final isDarkTheme = ref.watch(themeProvider);
    final themeNotifier = ref.watch(themeProvider.notifier);

    return Column(
      children: [
        SizedBox(
          height: 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 25),
              HeroIcon(
                isDarkTheme ? HeroIcons.moon : HeroIcons.sun,
                color: DrawerColorConstants.lightText,
                size: 27,
              ),
              const SizedBox(width: 15),
              Text(
                DrawerTextConstants.darkMode,
                style: TextStyle(
                  color: DrawerColorConstants.lightText,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 15),
              Switch(
                value: isDarkTheme,
                onChanged: (v) {
                  themeNotifier.toggleTheme();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  displayQuitNotifier.setDisplay(true);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 25),
                    HeroIcon(
                      HeroIcons.arrowRightOnRectangle,
                      color: DrawerColorConstants.lightText,
                      size: 27,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      DrawerTextConstants.logOut,
                      style: TextStyle(
                        color: DrawerColorConstants.lightText,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
