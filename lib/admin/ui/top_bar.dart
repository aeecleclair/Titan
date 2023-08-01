import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/router.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/drawer/providers/animation_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TopBar extends HookConsumerWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meNotifier = ref.watch(asyncUserProvider.notifier);
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
                      onPressed: () async {
                        if (QR.currentPath == AdminRouter.root) {
                          if (animation != null) {
                            final controllerNotifier = ref.watch(
                                swipeControllerProvider(animation).notifier);
                            controllerNotifier.toggle();
                          }
                          tokenExpireWrapper(ref, () async {
                            await meNotifier.loadMe();
                          });
                        } else {
                          QR.back();
                        }
                      },
                      icon: HeroIcon(
                        QR.currentPath == AdminRouter.root
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
