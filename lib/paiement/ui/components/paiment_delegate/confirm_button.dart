import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';

class ConfirmButton extends HookWidget {
  final VoidCallback onConfirm;
  final DateTime? itemExpirationDate;

  const ConfirmButton({
    super.key,
    required this.onConfirm,
    required this.itemExpirationDate,
  });

  @override
  Widget build(BuildContext context) {
    final localizeWithContext = AppLocalizations.of(context)!;
    final isDisabled = useState(false);
    final totalSeconds = itemExpirationDate
        ?.difference(DateTime.now())
        .inSeconds;

    final controller = useAnimationController(
      duration: Duration(seconds: totalSeconds ?? 0),
    );

    useEffect(() {
      controller.forward();
      void listener(AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          isDisabled.value = true;
        }
      }

      controller.addStatusListener(listener);
      return () => controller.removeStatusListener(listener);
    }, [controller]);

    Widget setAnimation(child) {
      if (totalSeconds != null &&
          (controller.isAnimating || controller.isCompleted)) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return child;
          },
        );
      }
      return child;
    }

    return setAnimation(
      GestureDetector(
        onTap: isDisabled.value ? onConfirm : null,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: [
                Center(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: isDisabled.value
                        ? BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          )
                        : BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff017f80),
                                Color.fromARGB(255, 4, 84, 84),
                              ],
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
                if (!isDisabled.value)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final shimmerWidth = constraints.maxWidth * 0.9;

                          // Start completely off left, end completely off right
                          final startPosition = -shimmerWidth * 1.5;
                          final endPosition = constraints.maxWidth;
                          final totalDistance = endPosition - startPosition;

                          return Transform.translate(
                            offset: Offset(
                              startPosition +
                                  (controller.value * totalDistance),
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
    );
  }
}
