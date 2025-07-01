import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';

/// A widget that displays event actions such as
/// invitation status and registration button.
class EventAction extends StatelessWidget {
  /// The text to display for the invitation status.
  final String invitationText;

  /// The number of participants (null if not applicable).
  final int? participantsCount;

  /// Callback when the action button is pressed.
  final VoidCallback? onActionPressed;

  /// Text to display on the action button.
  final String actionButtonText;

  const EventAction({
    super.key,
    this.invitationText = 'Tu es invité',
    this.participantsCount,
    this.onActionPressed,
    this.actionButtonText = 'Prendre ma place',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Invitation text with participant count
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              invitationText,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: ColorConstants.tertiary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '$participantsCount participants',
              style: const TextStyle(
                fontSize: 10,
                color: ColorConstants.secondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),

        const SizedBox(width: 8),

        // Action button
        GestureDetector(
          onTap: onActionPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: ColorConstants.tertiary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              actionButtonText,
              style: const TextStyle(
                fontSize: 12,
                color: ColorConstants.background,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
