import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/tools/image_color_utils.dart' as image_color_utils;
import 'package:titan/feed/tools/news_helper.dart';
import 'package:titan/feed/ui/widgets/adaptive_text_card.dart';
import 'package:titan/tools/constants.dart';

class EventCardTextContent extends ConsumerWidget {
  final News item;
  final dynamic localizeWithContext;
  final ImageProvider? imageProvider;

  const EventCardTextContent({
    super.key,
    required this.item,
    required this.imageProvider,
    required this.localizeWithContext,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dominantColor = ref.watch(dominantColorProvider(imageProvider));
    final textColor = dominantColor.maybeWhen(
      data: (color) => color != null
          ? image_color_utils.getTextColor(color)
          : ColorConstants.background,
      orElse: () => ColorConstants.background,
    );

    return Positioned(
      bottom: 10,
      left: 15,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  item.title.length > 15
                      ? '${item.title.substring(0, 15)}...'
                      : item.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.location != null && item.location!.isNotEmpty)
                  Expanded(
                    child: Text(
                      ' | ${item.location}',
                      style: TextStyle(fontSize: 14, color: textColor),
                      maxLines: 1,
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
      ),
    );
  }
}
