import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/l10n/app_localizations.dart';

class CountdownTimer extends HookWidget {
  final int totalSeconds;
  final int? fullDurationSeconds;
  final VoidCallback? onFinished;

  const CountdownTimer({
    super.key,
    required this.totalSeconds,
    this.fullDurationSeconds,
    this.onFinished,
  });

  @override
  Widget build(BuildContext context) {
    final localizeWithContext = AppLocalizations.of(context)!;
    final controller = useAnimationController(
      duration: Duration(seconds: totalSeconds),
    );

    useEffect(() {
      controller.forward();
      void listener(AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          onFinished?.call();
        }
      }

      controller.addStatusListener(listener);
      return () => controller.removeStatusListener(listener);
    }, [controller]);

    final animationValue = useAnimation(controller);
    final remainingSeconds = (totalSeconds * (1 - animationValue)).round();
    final fullDuration = fullDurationSeconds ?? totalSeconds;
    final elapsedFromFull = fullDuration - remainingSeconds;
    final progress = (elapsedFromFull / fullDuration).clamp(0.0, 1.0);
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');

    final colorScheme = Theme.of(context).colorScheme;
    final urgencyRatio = progress;
    final progressColor = Color.lerp(
      const Color(0xff017f80),
      colorScheme.error,
      urgencyRatio,
    )!;
    final backgroundColor = progressColor.withValues(alpha: 0.1);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: progressColor.withValues(alpha: 0.3), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: 1 - progress,
                  strokeWidth: 6,
                  backgroundColor: progressColor.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  strokeCap: StrokeCap.round,
                ),
              ),
              AnimatedScale(
                scale: remainingSeconds <= 10 ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$minutes:$seconds',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: progressColor,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localizeWithContext.paiementTimeRemaining,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: progressColor.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                remainingSeconds <= 30
                    ? localizeWithContext.paiementHurryUp
                    : localizeWithContext.paiementCompletePayment,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: progressColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
