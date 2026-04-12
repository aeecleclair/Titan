import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';

const _teal = Color(0xff017f80);

class FeedbackOverlay extends HookWidget {
  final bool isSuccess;
  const FeedbackOverlay({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );

    useEffect(() {
      controller.forward();
      return null;
    }, [controller]);

    final scaleAnim = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    );
    final fadeAnim = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );

    final color = isSuccess ? _teal : ColorConstants.main;

    return Center(
      child: FadeTransition(
        opacity: fadeAnim,
        child: ScaleTransition(
          scale: scaleAnim,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  boxShadow: [
                    BoxShadow(
                      color: color.withAlpha(77),
                      blurRadius: 20,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Icon(
                  isSuccess ? Icons.check_rounded : Icons.close_rounded,
                  color: Colors.white,
                  size: 44,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isSuccess
                    ? AppLocalizations.of(context)!.paiementPaymentSuccessful
                    : AppLocalizations.of(context)!.paiementPaymentCanceled,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
