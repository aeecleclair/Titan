import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_provider.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(adminPageProvider);
    final meNotifier = ref.watch(asyncUserProvider.notifier);
    final pageNotifier = ref.watch(adminPageProvider.notifier);
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
                      onPressed: () async {
                        switch (page) {
                          case AdminPage.main:
                            controllerNotifier.toggle();
                            tokenExpireWrapper(ref, () async {
                              await meNotifier.loadMe();
                            });
                            break;
                          case AdminPage.addAsso:
                            pageNotifier.setAdminPage(AdminPage.main);
                            break;
                          case AdminPage.edit:
                            pageNotifier.setAdminPage(AdminPage.main);
                            break;
                          case AdminPage.addLoaner:
                            pageNotifier.setAdminPage(AdminPage.main);
                            break;
                        }
                      },
                      icon: HeroIcon(
                        page == AdminPage.main
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(AdminTextConstants.administration,
                style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
