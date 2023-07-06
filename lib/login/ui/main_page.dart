import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/login/providers/animation_provider.dart';
import 'package:myecl/login/ui/background_painter.dart';

class LoginTemplate extends HookConsumerWidget {
  final Widget child;
  final void Function(AnimationController) callback;
  const LoginTemplate({Key? key, required this.child, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(animationProvider);
    callback(controller!);
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
