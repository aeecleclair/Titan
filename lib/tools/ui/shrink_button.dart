import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShrinkButton extends HookConsumerWidget {
  final VoidCallback? onTap;
  final Widget child;
  const ShrinkButton({Key? key, required this.onTap, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clicked = useState(false);
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.05,
    );

    void shrinkButtonSize() {
      animation.forward();
    }

    void restoreButtonSize() {
      animation.reverse();
    }

    return GestureDetector(
        onTap: () {
          if (clicked.value) return;
          onTap?.call();
          shrinkButtonSize();
          restoreButtonSize();
          clicked.value = true;
        },
        onTapDown: (_) {
          if (clicked.value) return;
          shrinkButtonSize();
          clicked.value = true;
        },
        onTapCancel: restoreButtonSize,
        child: Transform.scale(scale: 1 - animation.value, child: child));
  }
}
