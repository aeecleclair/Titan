import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/class/top_bar_callback.dart';
import 'package:myecl/drawer/providers/animation_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/providers/top_bar_callback_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CustomTopBar extends HookConsumerWidget {
  final String title;
  final String root;
  final VoidCallback? onMenu;
  final VoidCallback? onBack;
  final Widget? rightIcon;
  final TextStyle? textStyle;
  const CustomTopBar({
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
              width: 120,
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
                  style: textStyle ??
                      const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20), // Rounded top-left corner
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: rightIcon,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
