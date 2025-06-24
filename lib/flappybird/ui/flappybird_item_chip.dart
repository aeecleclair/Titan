import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/flappybird/router.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math' as math;

class FlappyBirdItemChip extends HookConsumerWidget {
  const FlappyBirdItemChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AnimationController controller = useAnimationController(
      duration: const Duration(seconds: 1),
    )..repeat();
    final pathForwardingNotifier = ref.watch(pathForwardingProvider.notifier);
    return GestureDetector(
      onTap: () {
        pathForwardingNotifier.forward(FlappyBirdRouter.root);
        QR.to(FlappyBirdRouter.root);
      },
      child: ItemChip(
        selected: true,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: math.pi * (-70 + controller.value * 160) / 360,
              child: Transform.translate(
                offset: Offset(-1 + controller.value * 5, -2),
                child: SvgPicture.asset(
                  "assets/images/logo_flappybird.svg",
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
