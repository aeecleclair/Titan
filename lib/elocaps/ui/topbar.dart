import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/elocaps/router.dart';
import 'package:myecl/elocaps/tools/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animation = useAnimationController(
        duration: const Duration(milliseconds: 3000), initialValue: 0)
      ..repeat(reverse: true);
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
                        if (QR.currentPath == ElocapsRouter.root) {
                          controllerNotifier.toggle();
                        } else {
                          QR.back();
                        }
                      },
                      icon: HeroIcon(
                        QR.currentPath == ElocapsRouter.root
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: 30,
                      ));
                },
              ),
            ),
            AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => LinearGradient(
                            colors: const [
                              Color.fromARGB(255, 12, 0, 0),
                              Color.fromARGB(255, 63, 2, 2),
                              Color.fromARGB(255, 251, 118, 70),
                              Color.fromARGB(255, 251, 194, 70),
                            ],
                            stops: [
                              0.0,
                              0.2 + 0.2 * animation.value,
                              0.5 + 0.5 * animation.value,
                              0.7 + 0.3 * animation.value
                            ],
                            tileMode: TileMode.mirror,
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ).createShader(bounds),
                      child: const Text(ElocapsTextConstant.elocaps,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)));
                }),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
      ],
    );
  }
}
