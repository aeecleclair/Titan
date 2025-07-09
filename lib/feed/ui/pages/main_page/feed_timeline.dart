import 'package:flutter/material.dart';
import 'package:titan/feed/class/feed_item.dart';
import 'package:titan/feed/ui/pages/main_page/time_line_item.dart';

class FeedTimeline extends StatelessWidget {
  final List<FeedItem> items;
  final Function(FeedItem item)? onItemTap;

  const FeedTimeline({super.key, required this.items, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...items.map(
          (item) => TimelineItem(
            item: item,
            onTap: onItemTap != null ? () => onItemTap!(item) : null,
          ),
        ),
        SizedBox(height: 80),
      ],
    );
  }
}
