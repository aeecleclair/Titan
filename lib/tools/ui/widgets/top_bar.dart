import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/drawer/class/top_bar_callback.dart';
import 'package:titan/drawer/providers/animation_provider.dart';
import 'package:titan/drawer/providers/swipe_provider.dart';
import 'package:titan/drawer/providers/top_bar_callback_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TopBar extends HookConsumerWidget {
  final String title;
  final String root;
  final VoidCallback? onMenu;
  final VoidCallback? onBack;
  final Widget? rightIcon;
  final TextStyle? textStyle;
  const TopBar({
    super.key,
    required this.title,
    required this.root,
    this.onMenu,
    this.onBack,
    this.rightIcon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animation = ref.watch(animationProvider);
    final topBarCallBackNotifier = ref.watch(topBarCallBackProvider.notifier);
    Future(() {
      topBarCallBackNotifier.setCallBacks(
        TopBarCallback(moduleRoot: root, onMenu: onMenu, onBack: onBack),
      );
    });
    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
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
                            swipeControllerProvider(animation).notifier,
                          );
                          controllerNotifier.toggle();
                          onMenu?.call();
                        }
                      } else {
                        QR.back();
                        onBack?.call();
                      }
                    },
                    icon: HeroIcon(
                      QR.currentPath == root
                          ? HeroIcons.bars3BottomLeft
                          : HeroIcons.chevronLeft,
                      color: textStyle?.color ?? Colors.black,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Center(
                child: AutoSizeText(
                  title,
                  maxLines: 1,
                  style:
                      textStyle ??
                      const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                ),
              ),
            ),
            SizedBox(width: 70, child: rightIcon),
          ],
        ),
      ],
    );
  }
}
