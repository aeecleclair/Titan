import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/admin/providers/is_admin.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/tools/constants.dart';
import 'package:myecl/home/providers/scrolled_provider.dart';

class BottomBar extends ConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const BottomBar({Key? key, required this.controllerNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(pageProvider);
    final pageNotifier = ref.watch(pageProvider.notifier);
    final hasScrolled = ref.watch(hasScrolledProvider.notifier);
    final isAdmin = ref.watch(isAdminProvider);
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  pageNotifier.setPage(ModuleType.settings);
                  controllerNotifier.toggle();
                  hasScrolled.setHasScrolled(false);
                },
                onDoubleTap: () {
                  pageNotifier.setPage(ModuleType.settings);
                  controllerNotifier.toggle();
                  hasScrolled.setHasScrolled(false);
                },
                child: Row(
                  children: [
                    Container(
                      width: 25,
                    ),
                    HeroIcon(
                      HeroIcons.cog,
                      color: page == ModuleType.settings
                          ? DrawerColorConstants.selectedText
                          : DrawerColorConstants.lightText,
                      size: 25,
                    ),
                    Container(
                      width: 15,
                    ),
                    Text("Paramètres",
                        style: TextStyle(
                          color: page == ModuleType.settings
                              ? DrawerColorConstants.selectedText
                              : DrawerColorConstants.lightText,
                          fontSize: 15,
                        ))
                  ],
                ),
              ),
              isAdmin
                  ? GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        pageNotifier.setPage(ModuleType.admin);
                        controllerNotifier.toggle();
                        hasScrolled.setHasScrolled(false);
                      },
                      onDoubleTap: () {
                        pageNotifier.setPage(ModuleType.admin);
                        controllerNotifier.toggle();
                        hasScrolled.setHasScrolled(false);
                      },
                      child: Row(
                        children: [
                          HeroIcon(
                            HeroIcons.userGroup,
                            color: page == ModuleType.admin
                                ? DrawerColorConstants.selectedText
                                : DrawerColorConstants.lightText,
                            size: 25,
                          ),
                          Container(
                            width: 15,
                          ),
                          Text("Administration",
                              style: TextStyle(
                                color: page == ModuleType.admin
                                    ? DrawerColorConstants.selectedText
                                    : DrawerColorConstants.lightText,
                                fontSize: 15,
                              )),
                          Container(
                            width: 25,
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        Container(
          height: 20,
        )
      ],
    );
  }
}
