import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/settings/providers/settings_page_provider.dart';
import 'package:myecl/settings/tools/constants.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(settingsPageProvider);
    final pageNotifier = ref.watch(settingsPageProvider.notifier);
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: Builder(
                builder: (BuildContext appBarContext) {
                  return IconButton(
                      onPressed: () {
                        switch (page) {
                          case SettingsPage.main:
                            controllerNotifier.toggle();
                            break;
                          case SettingsPage.edit:
                            pageNotifier.setSettingsPage(SettingsPage.main);
                            break;
                          case SettingsPage.changePassword:
                            pageNotifier.setSettingsPage(SettingsPage.main);
                            break;
                          case SettingsPage.notification:
                            pageNotifier.setSettingsPage(SettingsPage.main);
                            break;
                          case SettingsPage.logs:
                            pageNotifier.setSettingsPage(SettingsPage.main);
                            break;
                          case SettingsPage.modules:
                            pageNotifier.setSettingsPage(SettingsPage.main);
                            break;
                        }
                      },
                      icon: HeroIcon(
                        page == SettingsPage.main
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(SettingsTextConstants.settings,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
