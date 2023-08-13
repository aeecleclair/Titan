import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/animation_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TopBar extends HookConsumerWidget {
  final String title;
  final String root;
  final VoidCallback? onBack;
  final Widget? rightIcon;
  const TopBar(
      {Key? key,
      required this.title,
      required this.root,
      this.onBack,
      this.rightIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animation = ref.watch(animationProvider);
    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: Builder(
                builder: (BuildContext appBarContext) {
                  return IconButton(
                      onPressed: () {
                        if (QR.currentPath == root) {
                          if (animation != null) {
                            final controllerNotifier = ref.watch(
                                swipeControllerProvider(animation).notifier);
                            controllerNotifier.toggle();
                            onBack?.call();
                          }
                        } else {
                          QR.back();
                        }
                      },
                      icon: HeroIcon(
                        QR.currentPath == root
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: 30,
                      ));
                },
              ),
            ),
            Text(title,
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            SizedBox(width: 70, child: rightIcon),
          ],
        ),
      ],
    );
  }
}
