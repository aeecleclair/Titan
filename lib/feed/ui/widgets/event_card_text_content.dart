import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/tools/news_helper.dart';

class EventCardTextContent extends ConsumerWidget {
  final News item;
  final dynamic localizeWithContext;

  const EventCardTextContent({
    super.key,
    required this.item,
    required this.localizeWithContext,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                item.title.length > 30
                    ? '${item.title.substring(0, 30)}...'
                    : item.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (item.location != null && item.location!.isNotEmpty)
                Expanded(
                  child: Text(
                    ' | ${item.location}',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          AutoSizeText(
            minFontSize: 10,
            maxLines: 1,
            getNewsSubtitle(item, context: context),
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
