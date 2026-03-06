import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/styleguide/button.dart';

const _teal = Color(0xff017f80);
const _tealDark = Color.fromARGB(255, 4, 84, 84);

class ConfirmButton extends HookWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final int? totalSeconds;

  const ConfirmButton({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    required this.totalSeconds,
  });

  @override
  Widget build(BuildContext context) {
    final localizeWithContext = AppLocalizations.of(context)!;
    final isExpired = useState(false);

    // Expiration timer: runs once over totalSeconds
    final expirationController = useAnimationController(
      duration: Duration(seconds: totalSeconds ?? 0),
    );

    // Shimmer: repeating fast sweep (1.5s per cycle)
    final shimmerController = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    );

    useEffect(() {
      if (totalSeconds != null && totalSeconds! > 0) {
        expirationController.forward();
      }
      void listener(AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          isExpired.value = true;
          shimmerController.stop();
        }
      }

      expirationController.addStatusListener(listener);
      shimmerController.repeat();
      return () {
        expirationController.removeStatusListener(listener);
      };
    }, [expirationController, shimmerController]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: isExpired.value ? null : onConfirm,
          child: AnimatedBuilder(
            animation: shimmerController,
            builder: (context, child) {
              return Stack(
                children: [
                  Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      decoration: isExpired.value
                          ? BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            )
                          : BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [_teal, _tealDark],
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                      child: Text(
                        localizeWithContext.paiementConfirmPayment,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorConstants.background,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  if (!isExpired.value)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final shimmerWidth = constraints.maxWidth * 0.9;
                            final startPosition = -shimmerWidth * 1.5;
                            final endPosition = constraints.maxWidth;
                            final totalDistance = endPosition - startPosition;

                            return Transform.translate(
                              offset: Offset(
                                startPosition +
                                    (shimmerController.value * totalDistance),
                                0,
                              ),
                              child: Container(
                                width: shimmerWidth,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.0),
                                      Colors.white.withOpacity(0.2),
                                      Colors.white.withOpacity(0.0),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Button.secondary(
          text: localizeWithContext.paiementCancel,
          onPressed: onCancel,
        ),
      ],
    );
  }
}
