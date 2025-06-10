import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/login/providers/animation_provider.dart';
import 'package:titan/login/ui/components/background_painter.dart';

class LoginTemplate extends HookConsumerWidget {
  final Widget child;
  final void Function(AnimationController) callback;
  const LoginTemplate({super.key, required this.child, required this.callback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AnimationController? controller = ref.watch(backgroundAnimationProvider);
    controller ??= useAnimationController(
      duration: const Duration(milliseconds: 500),
      initialValue: 0.0,
    );
    callback(controller);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(animation: controller),
            ),
          ),
          SafeArea(child: Center(child: child)),
        ],
      ),
    );
  }
}
