import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:titan/feed/class/feed_item.dart';
import 'package:titan/feed/ui/pages/main_page/event_action.dart';
import 'package:titan/feed/ui/pages/main_page/event_card.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/feed/ui/pages/main_page/dotted_vertical_line.dart';

class TimelineItem extends StatelessWidget {
  final FeedItem item;
  final VoidCallback? onTap;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.item,
    this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('d').format(item.date),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.main,
                      ),
                    ),
                    Text(
                      DateFormat('MMM').format(item.date).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.onTertiary,
                      ),
                    ),
                    // Expanded(child: DottedVerticalLine()),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: EventCard(item: item),
                ),
              ),
            ],
          ),
          if (item.type != FeedItemType.announcement)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 45),
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorConstants.secondary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: EventAction(
                      title: item.type == FeedItemType.action
                          ? 'Tu peux voter'
                          : 'Tu es invité',
                      subtitle: item.type == FeedItemType.action
                          ? '254 votants'
                          : '75 participants',
                      onActionPressed: item.onRegister,
                      actionButtonText: item.type == FeedItemType.action
                          ? 'Participer'
                          : 'Voter',
                      isActionEnabled: true,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
