import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/settings/providers/settings_page_provider.dart';
import 'package:myecl/settings/ui/page_switcher.dart';
import 'package:myecl/settings/ui/top_bar.dart';

class SettingsHomePage extends ConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const SettingsHomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(settingsPageProvider);
    final pageNotifier = ref.watch(settingsPageProvider.notifier);
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        switch (page) {
          case SettingsPage.main:
            if (!controller.isCompleted) {
              controllerNotifier.toggle();
              break;
            } else {
              return true;
            }
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
        }
        return false;
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: IgnorePointer(
            ignoring: controller.isCompleted,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TopBar(
                  controllerNotifier: controllerNotifier,
                ),
                const Expanded(child: PageSwitcher()),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
