import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';

class EventAction extends StatelessWidget {
  final String title, subtitle, actionButtonText;
  final VoidCallback? onActionPressed;
  final bool isActionEnabled;

  const EventAction({
    super.key,
    required this.title,
    required this.subtitle,
    this.onActionPressed,
    required this.actionButtonText,
    required this.isActionEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: ColorConstants.onTertiary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
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

        // Action button
        GestureDetector(
          onTap: () {
            if (isActionEnabled) onActionPressed!.call();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            width: 100,
            decoration: BoxDecoration(
              color: isActionEnabled
                  ? ColorConstants.background
                  : ColorConstants.tertiary,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ColorConstants.tertiary, width: 2),
            ),
            child: Center(
              child: Text(
                actionButtonText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isActionEnabled
                      ? ColorConstants.tertiary
                      : ColorConstants.background,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
