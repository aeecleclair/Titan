import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/tools/news_helper.dart';
import 'package:titan/feed/ui/pages/main_page/event_action.dart';
import 'package:titan/feed/ui/pages/main_page/event_action_admin.dart';
import 'package:titan/feed/ui/pages/main_page/event_card.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/feed/ui/pages/main_page/dotted_vertical_line.dart';

class TimelineItem extends StatelessWidget {
  final News item;
  final VoidCallback? onTap;
  final bool isAdmin;

  const TimelineItem({
    super.key,
    required this.item,
    this.onTap,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: item.actionStart != null || isAdmin ? 200 : 160,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 23),
            child: DottedVerticalLine(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
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
                            DateFormat('d').format(item.start),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.main,
                            ),
                          ),
                          Text(
                            DateFormat('MMM').format(item.start).toUpperCase(),
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
                if (item.actionStart != null || isAdmin)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 14,
                            right: isAdmin ? 33 : 45,
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
                          child: !isAdmin
                              ? EventActionAdmin(item: item)
                              : EventAction(
                                  title: getActionTitle(item, context),
                                  subtitle: getActionSubtitle(item, context),
                                  onActionPressed: () =>
                                      getActionButtonAction(item),
                                  actionEnableButtonText:
                                      getActionEnableButtonText(item, context),
                                  actionValidatedButtonText:
                                      getActionValidatedButtonText(
                                        item,
                                        context,
                                      ),
                                  isActionValidated: true,
                                  isActionEnabled:
                                      (item.actionStart ?? item.start).isBefore(
                                        DateTime.now(),
                                      ) &&
                                      item.end != null &&
                                      item.end!.isAfter(DateTime.now()),
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
  }
}
