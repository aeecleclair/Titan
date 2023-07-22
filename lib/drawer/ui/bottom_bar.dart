import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/providers/display_quit_popup.dart';
import 'package:myecl/drawer/tools/constants.dart';
class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayQuitNotifier = ref.watch(displayQuitProvider.notifier);
    return Column(
      children: [
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
                    Container(
                      width: 25,
                    ),
                    HeroIcon(
                      HeroIcons.arrowRightOnRectangle,
                      color: DrawerColorConstants.lightText,
                      size: 27,
                    ),
                    Container(
                      width: 15,
                    ),
                    Text(DrawerTextConstants.logOut,
                        style: TextStyle(
                          color: DrawerColorConstants.lightText,
                          fontSize: 18,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 30,
        )
      ],
    );
  }
}
