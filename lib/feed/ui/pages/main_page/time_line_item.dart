import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/tools/news_helper.dart';
import 'package:titan/feed/ui/pages/main_page/event_action.dart';
import 'package:titan/feed/ui/pages/main_page/event_card.dart';
import 'package:titan/feed/ui/widgets/event_card_text_content.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/feed/ui/pages/main_page/dotted_vertical_line.dart';

class TimelineItem extends ConsumerWidget {
  final News item;
  final VoidCallback? onTap;

  const TimelineItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
    final localizeWithContext = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final eventCardWidth = constraints.maxWidth - 70;
        final eventCardHeight = eventCardWidth / (851 / 315);

        final baseHeight = 30 + eventCardHeight + 17;

        final totalHeight = item.actionStart != null
            ? baseHeight + 55
            : baseHeight;

        return SizedBox(
          height: totalHeight,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 23),
                child: DottedVerticalLine(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 30),
                          color: ColorConstants.background,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat.d(
                                  locale.toString(),
                                ).format(item.start),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.main,
                                ),
                              ),
                              Text(
                                DateFormat.MMM(
                                  locale.toString(),
                                ).format(item.start).toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.onTertiary,
                                ),
                              ),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 45),
                      child: EventCardTextContent(
                        item: item,
                        localizeWithContext: localizeWithContext,
                      ),
                    ),
                    if (item.actionStart != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 14,
                                right: 37,
                                top: 3,
                              ),
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstants.background,
                                  border: Border.all(
                                    color: ColorConstants.secondary,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: EventAction(
                                title: getActionTitle(item, context),
                                waitingTitle: (timeToGo) => getWaitingTitle(
                                  item,
                                  context,
                                  timeToGo: timeToGo,
                                ),
                                subtitle: getActionSubtitle(item, context),
                                onActionPressed: () =>
                                    getActionButtonAction(item, context, ref),
                                actionEnableButtonText:
                                    getActionEnableButtonText(item, context),
                                actionValidatedButtonText:
                                    getActionValidatedButtonText(item, context),
                                isActionValidated: false,
                                eventEnd: item.end,
                                timeOpening: item.actionStart,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
