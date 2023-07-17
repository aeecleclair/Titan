import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShrinkButton extends HookWidget {
  final Widget child;
  final Widget Function(Widget) builder;
  final Color waitingColor;
  final Future Function() onTap;

  ShrinkButton(
      {super.key,
      required this.child,
      required this.onTap,
      required this.builder,
      this.waitingColor = Colors.white});

  final clicked = useState(false);

  final AnimationController animationController = useAnimationController(
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1);

  void _shrinkButtonSize() {
    animationController.forward();
  }

  void _restoreButtonSize() {
    animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if (clicked.value) return;
        clicked.value = true;
        _shrinkButtonSize();
        onTap().then((_) {
          _restoreButtonSize();
          clicked.value = false;
        });
      },
      onTapDown: (_) {
        _shrinkButtonSize();
      },
      onTapCancel: () {
        _restoreButtonSize();
      },
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Transform.scale(
              scale: 1 - animationController.value,
              child: builder(child!)),
          child: clicked.value
              ? Center(child: CircularProgressIndicator(color: waitingColor))
              : child),
    );
  }
}
