import 'package:flutter/material.dart';
import 'package:titan/feed/class/feed_item.dart';
import 'package:titan/feed/ui/pages/main_page/time_line_item.dart';
import 'package:titan/tools/ui/widgets/dotted_vertical_line.dart';

class FeedTimeline extends StatelessWidget {
  final List<FeedItem> items;
  final Function(FeedItem item)? onItemTap;

  const FeedTimeline({super.key, required this.items, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...items.map((item) {
          final index = items.indexOf(item);
          return TimelineItem(
            item: item,
            onTap: onItemTap != null ? () => onItemTap!(item) : null,
            isLast: index == items.length - 1,
          );
        }),
        SizedBox(height: 80),
      ],
    );
  }
}
