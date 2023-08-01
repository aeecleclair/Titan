import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/animation_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/tombola/router.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TopBar extends HookConsumerWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animation = ref.watch(animationProvider);
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
                        if (QR.currentPath == RaffleRouter.root) {
                          if (animation != null) {
                            final controllerNotifier = ref.watch(
                                swipeControllerProvider(animation).notifier);
                            controllerNotifier.toggle();
                          }
                        } else {
                          QR.back();
                        }
                      },
                      icon: HeroIcon(
                        QR.currentPath == RaffleRouter.root
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(TombolaTextConstants.raffle,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
      ],
    );
  }
}
