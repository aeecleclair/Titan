import 'package:flutter/material.dart';

class ShrinkButton extends StatefulWidget {
  final Container child;
  final Widget waitChild;
  final Future Function() onTap;

  const ShrinkButton(
      {super.key,
      required this.child,
      required this.onTap,
      this.waitChild = const SizedBox()});

  @override
  ShrinkButtonState createState() => ShrinkButtonState();
}

class ShrinkButtonState extends State<ShrinkButton>
    with SingleTickerProviderStateMixin {
  static const clickAnimationDurationMillis = 100;

  double _scaleTransformValue = 1;
  bool clicked = false;

  // needed for the "click" tap effect
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: clickAnimationDurationMillis),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() => _scaleTransformValue = 1 - animationController.value);
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _shrinkButtonSize() {
    animationController.forward();
  }

  void _restoreButtonSize() {
    animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (clicked) return;
        setState(() {
          clicked = true;
        });
        _shrinkButtonSize();
        widget.onTap().then((_) {
          _restoreButtonSize();
          setState(() {
            clicked = false;
          });
        });
      },
      onTapDown: (_) {
        _shrinkButtonSize();
      },
      onTapCancel: () {
        _restoreButtonSize();
      },
      child: Transform.scale(
          scale: _scaleTransformValue,
          child: clicked ? widget.waitChild : widget.child),
    );
  }
}
