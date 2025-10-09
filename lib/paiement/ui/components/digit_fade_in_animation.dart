import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DigitFadeInAnimation extends HookWidget {
  final Widget child;
  const DigitFadeInAnimation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );

    final fadeAnimation = useAnimation(
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        ),
      ),
    );

    final slideAnimation = useAnimation(
      Tween<Offset>(begin: const Offset(0.0, -1), end: Offset.zero).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        ),
      ),
    );

    useEffect(() {
      animationController.forward();
      return () {
        animationController.reverse();
      };
    }, []);

    return Transform.translate(
      offset: slideAnimation,
      child: Opacity(opacity: fadeAnimation, child: child),
    );
  }
}
