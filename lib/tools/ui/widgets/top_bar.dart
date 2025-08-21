import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TopBar extends HookConsumerWidget {
  final String root;
  final VoidCallback? onBack;
  final Widget? rightIcon;
  final TextStyle? textStyle;
  const TopBar({
    super.key,
    required this.root,
    this.onBack,
    this.rightIcon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 70,
              height: 30,
              child: Builder(
                builder: (BuildContext appBarContext) {
                  if (QR.currentPath == root) {
                    return SizedBox.shrink();
                  }
                  return IconButton(
                    onPressed: () {
                      QR.back();
                      onBack?.call();
                    },
                    icon: HeroIcon(
                      HeroIcons.chevronLeft,
                      color: textStyle?.color ?? Colors.black,
                      size: 20,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Center(
                child: AutoSizeText(
                  "myemapp",
                  maxLines: 1,
                  style:
                      textStyle ??
                      const TextStyle(
                        fontSize: 15,
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
