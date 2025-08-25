import 'package:flutter/material.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/tools/news_helper.dart';
import 'package:titan/feed/ui/widgets/adaptive_text_card.dart';
import 'package:titan/tools/constants.dart';

class EventCardTextContent extends StatelessWidget {
  final News item;
  final dynamic localizeWithContext;

  const EventCardTextContent({
    super.key,
    required this.item,
    required this.localizeWithContext,
  });

  @override
  Widget build(BuildContext context) {
    final provider = AdaptiveTextProvider.of(context);
    final textColor = provider?.getTextColor() ?? ColorConstants.background;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 70),
          Row(
            children: [
              Expanded(
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (item.location != null && item.location!.isNotEmpty)
                Flexible(
                  child: Text(
                    ' | ${item.location}',
                    style: TextStyle(fontSize: 14, color: textColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          Text(
            getNewsSubtitle(item, context: context),
            style: TextStyle(fontSize: 12, color: textColor),
          ),
        ],
      ),
    );
  }
}
