import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/tools/constants.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/centralisation/providers/centralisation_page_provider.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(centralisationPageProvider);

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
                        case CentralisationPage.main:
                          controllerNotifier.toggle();
                          break;
                      }
                    },
                    icon: HeroIcon(
                      page == CentralisationPage.main
                          ? HeroIcons.bars3BottomLeft
                          : HeroIcons.chevronLeft,
                      color: Colors.black,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
            const Expanded(
              child: AutoSizeText(
                CentralisationTextConstants.centralisation,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
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