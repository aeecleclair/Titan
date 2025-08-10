import 'package:flutter/material.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/ui/pages/main_page/time_line_item.dart';

class FeedTimeline extends StatelessWidget {
  final List<News> items;
  final Function(News item)? onItemTap;
  final bool isAdmin;

  const FeedTimeline({super.key, required this.items, this.onItemTap, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...items.map(
          (item) => TimelineItem(
            item: item,
            isAdmin: isAdmin,
            onTap: onItemTap != null ? () => onItemTap!(item) : null,
          ),
        ),
        SizedBox(height: 80),
      ],
    );
  }
}
