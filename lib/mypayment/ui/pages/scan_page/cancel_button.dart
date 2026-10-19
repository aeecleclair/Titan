import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/tools/constants.dart';
import 'package:titan/tools/providers/theme_provider.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class CancelButton extends ConsumerWidget {
  final Future Function(bool) onCancel;

  const CancelButton({super.key, required this.onCancel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disablingAnimationController = useAnimationController(
      duration: const Duration(seconds: 30),
    )..forward();
    final isDarkTheme = ref.watch(themeProvider);

    return Expanded(
      child: WaitingButton(
        builder: (child) => Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.tertiary,
          ),
          child: child,
        ),
        onTap: () => onCancel(disablingAnimationController.isAnimating),
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraint) {
                return AnimatedBuilder(
                  animation: disablingAnimationController,
                  builder: (context, child) {
                    if (disablingAnimationController.value == 1) {
                      return Container();
                    }
                    return Container(
                      width:
                          constraint.maxWidth *
                          (1 - disablingAnimationController.value),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: RadialGradient(
                          colors: [
                            MyPaymentColors(
                              isDarkTheme,
                            ).redGradient1.withValues(alpha: 0.8),
                            MyPaymentColors(
                              isDarkTheme,
                            ).redGradient2.withValues(alpha: 0.8),
                          ],
                          center: Alignment.topLeft,
                          radius: 1.3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: MyPaymentColors(
                              isDarkTheme,
                            ).redGradient2.withValues(alpha: 0.3),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            AnimatedBuilder(
              animation: disablingAnimationController,
              builder: (context, child) {
                return Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Annuler (${((1 - disablingAnimationController.value) * 30).toStringAsFixed(0)}s)',
                    style: TextStyle(
                      color: MyPaymentColors.onGradient,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
