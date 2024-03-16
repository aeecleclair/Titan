import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myecl/tools/ui/widgets/loader.dart';

class WaitingButton extends HookWidget {
  final Widget child;
  final Widget Function(Widget) builder;
  final Color waitingColor;
  final Future Function()? onTap;

  const WaitingButton({
    super.key,
    required this.child,
    required this.onTap,
    required this.builder,
    this.waitingColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final clicked = useState(false);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );

    void shrinkButtonSize() => animationController.forward();

    void restoreButtonSize() => animationController.reverse();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if (clicked.value) return;
        clicked.value = true;
        shrinkButtonSize();
        onTap?.call().then((_) {
          restoreButtonSize();
          clicked.value = false;
        });
      },
      onTapCancel: restoreButtonSize,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Transform.scale(
          scale: 1 - animationController.value,
          child: builder(child!),
        ),
        child: clicked.value ? Loader(color: waitingColor) : child,
      ),
    );
  }
}
