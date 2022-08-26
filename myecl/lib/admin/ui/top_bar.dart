import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(adminPageProvider);
    final pageNotifier = ref.watch(adminPageProvider.notifier);
    return Column(
      children: [
        const SizedBox(
          height: 42,
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
                          case AdminPage.main:
                            controllerNotifier.toggle();
                            break;
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
                      },
                      icon: FaIcon(
                        page == AdminPage.main
                            ? FontAwesomeIcons.chevronRight
                            : FontAwesomeIcons.chevronLeft,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ));
                },
              ),
            ),
            const Text(
              AdminTextConstants.administration,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
