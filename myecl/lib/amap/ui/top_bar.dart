import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(amapPageProvider);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
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
                          case AmapPage.main:
                            controllerNotifier.toggle();
                            break;
                          case AmapPage.pres:
                            pageNotifier.setAmapPage(AmapPage.main);
                            break;
                          case AmapPage.products:
                            clearCmd(ref);
                            pageNotifier.setAmapPage(AmapPage.main);
                            break;
                          case AmapPage.admin:
                            pageNotifier.setAmapPage(AmapPage.main);
                            break;
                          case AmapPage.modif:
                            pageNotifier.setAmapPage(AmapPage.admin);
                            break;
                          case AmapPage.addCmd:
                            pageNotifier.setAmapPage(AmapPage.admin);
                            break;
                          case AmapPage.delivery:
                            pageNotifier.setAmapPage(AmapPage.main);
                            break;
                          case AmapPage.solde:
                            pageNotifier.setAmapPage(AmapPage.admin);
                            break;
                          case AmapPage.addSolde:
                            pageNotifier.setAmapPage(AmapPage.solde);
                            break;
                        }
                      },
                      icon: FaIcon(
                        page == AmapPage.main
                            ? FontAwesomeIcons.chevronRight
                            : FontAwesomeIcons.chevronLeft,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ));
                },
              ),
            ),
            const Text(
              "Amap",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
      ],
    );
  }
}
