import 'package:flutter/material.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/ui/pages/main_page/time_line_item.dart';

class FeedTimeline extends StatelessWidget {
  final List<News> items;
  final Function(News item)? onItemTap;
  final bool isAdmin;

  const FeedTimeline({
    super.key,
    required this.items,
    this.onItemTap,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    items.sort((a, b) {
      if (a.start == b.start) {
        if (a.end == null && b.end == null) return 0;
        if (a.end == null) return -1;
        if (b.end == null) return 1;
        return a.end!.compareTo(b.end!);
      }
      return a.start.compareTo(b.start);
    });
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
