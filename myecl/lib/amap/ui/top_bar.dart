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
                        if (page == 0) {
                          controllerNotifier.toggle();
                        } else {
                          if (page == 3) {
                            pageNotifier.setAmapPage(0);
                          } else {
                            // Si on est sur la page des produits on annule la commande ou ses changements
                            if (page == 2) {
                              clearCmd(ref);
                            }
                            // On revient sur la page précédente
                            pageNotifier.setAmapPage(max(page - 1, 0));
                          }
                        }
                      },
                      icon: FaIcon(
                        page == 0
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
