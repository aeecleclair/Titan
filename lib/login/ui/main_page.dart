import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/login/ui/background_painter.dart';

class LoginTemplate extends HookConsumerWidget {
  final Widget child;
  const LoginTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AnimationController controller =
        useAnimationController(duration: const Duration(seconds: 2));
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: controller,
              ),
            ),
          ),
          SafeArea(
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}
