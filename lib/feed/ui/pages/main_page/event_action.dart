import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:timeago_flutter/timeago_flutter.dart';
import 'package:titan/tools/constants.dart';

class EventAction extends HookWidget {
  final String title,
      subtitle,
      actionEnableButtonText,
      actionValidatedButtonText;
  final String Function(String timeToGo) waitingTitle;
  final DateTime? timeOpening, eventEnd;
  final VoidCallback? onActionPressed;
  final bool isActionValidated;

  const EventAction({
    super.key,
    required this.title,
    required this.subtitle,
    this.onActionPressed,
    required this.actionEnableButtonText,
    required this.actionValidatedButtonText,
    required this.isActionValidated,
    required this.timeOpening,
    required this.eventEnd,
    required this.waitingTitle,
  });

  @override
  Widget build(BuildContext context) {
    final now = useState(DateTime.now());
    final locale = Localizations.localeOf(context);

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        now.value = DateTime.now();
      });

      return timer.cancel;
    }, []);

    final isActionEnabled =
        timeOpening != null &&
        timeOpening!.isBefore(now.value) &&
        eventEnd != null &&
        eventEnd!.isAfter(now.value);

    final isWaiting = timeOpening != null && timeOpening!.isAfter(now.value);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isWaiting ? 'Prépares-toi' : title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: ColorConstants.onTertiary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            timeOpening != null &&
                    eventEnd != null &&
                    eventEnd!.isAfter(now.value) &&
                    timeOpening!.isAfter(now.value)
                ? Timeago(
                    date: timeOpening!,
                    locale: '${locale.languageCode}_short',
                    allowFromNow: true,
                    refreshRate: const Duration(seconds: 1),
                    builder: (context, str) => Text(
                      waitingTitle(str),
                      style: const TextStyle(
                        fontSize: 11,
                        color: ColorConstants.secondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: ColorConstants.secondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
          ],
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            if (isActionEnabled && !isActionValidated) onActionPressed!.call();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            width: 100,
            decoration: BoxDecoration(
              color: isActionValidated
                  ? ColorConstants.tertiary
                  : ColorConstants.background,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: ColorConstants.tertiary.withValues(
                  alpha: isActionEnabled && !isActionValidated ? 1 : 0.5,
                ),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                isActionValidated
                    ? actionValidatedButtonText
                    : actionEnableButtonText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color:
                      (isActionValidated
                              ? ColorConstants.background
                              : ColorConstants.tertiary)
                          .withValues(
                            alpha: isActionEnabled && !isActionValidated
                                ? 1
                                : 0.5,
                          ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
