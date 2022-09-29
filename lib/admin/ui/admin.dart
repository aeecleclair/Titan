import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/ui/page_switcher.dart';
import 'package:myecl/admin/ui/top_bar.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';

class AdminHomePage extends ConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const AdminHomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(adminPageProvider);
    final pageNotifier = ref.watch(adminPageProvider.notifier);
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        switch (page) {
          case AdminPage.main:
            if (!controller.isCompleted) {
              controllerNotifier.toggle();
              break;
            } else {
              return true;
            }
          case AdminPage.asso:
            pageNotifier.setAdminPage(AdminPage.main);
            break;
          case AdminPage.addAsso:
            pageNotifier.setAdminPage(AdminPage.main);
            break;
          case AdminPage.addMember:
            pageNotifier.setAdminPage(AdminPage.edit);
            break;
          case AdminPage.edit:
            pageNotifier.setAdminPage(AdminPage.asso);
            break;
          case AdminPage.addLoaner:
            pageNotifier.setAdminPage(AdminPage.main);
            break;
        }
        return false;
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
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
    ));
  }
}
