import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/theme_provider.dart';

class BookingCard extends ConsumerWidget {
  final Booking booking;
  final Function()? onEdit, onConfirm, onDecline, onCopy, onInfo;
  final Future Function()? onDelete;
  final bool isAdmin, isDetail;
  const BookingCard({
    super.key,
    required this.booking,
    this.onEdit,
    this.onConfirm,
    this.onDecline,
    this.onInfo,
    this.onCopy,
    this.onDelete,
    this.isAdmin = false,
    this.isDetail = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNotEnded = booking.recurrenceRule.isNotEmpty
        ? SfCalendar.parseRRule(booking.recurrenceRule, booking.start)
            .endDate!
            .isAfter(DateTime.now())
        : booking.end.isAfter(DateTime.now());
    final showButton =
        (isNotEnded && booking.decision == Decision.pending) || isAdmin;
    final isDarkTheme = ref.watch(themeProvider);
    final List<Color> cardColor;
    final Color smallTextColor;
    final Color bigTextColor;
    final Color secondaryIconBackgroundColor;
    final Color primaryIconBackgroundColor;
    final Color primaryIconColor;
    final Color cardBoxShadow;
    final Color informationCircleColor;

    switch (booking.decision) {
      case Decision.pending:
        cardColor = [
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.surface,
        ];
        secondaryIconBackgroundColor = Theme.of(context).colorScheme.secondary;
        break;

      case Decision.approved:
        cardColor = isDarkTheme
            ? [
                const Color(0xFF387000),
                const Color(0xFF54a800),
              ]
            : [
                const Color(0xFF54A800),
                const Color(0xFF387000),
              ];
        secondaryIconBackgroundColor =
            isDarkTheme ? const Color(0xFF7EFC00) : const Color(0xFF1C3800);
        break;

      case Decision.declined:
        cardColor = isDarkTheme
            ? [
                const Color(0xFFA82A00),
                const Color(0xFFFC3F00),
              ]
            : [
                const Color(0xFFFC3F00),
                const Color(0xFFA82A00),
              ];
        secondaryIconBackgroundColor =
            isDarkTheme ? const Color(0xFFFF2A00) : const Color(0xFF541500);
        break;
    }

    primaryIconColor = secondaryIconBackgroundColor;

    if (booking.decision == Decision.pending) {
      smallTextColor = Theme.of(context).colorScheme.tertiary;
      cardBoxShadow = Theme.of(context).shadowColor;
      primaryIconBackgroundColor = Theme.of(context).colorScheme.surface;
      bigTextColor = Theme.of(context).colorScheme.onSurface;
    } else {
      smallTextColor =
          Theme.of(context).colorScheme.onSecondary.withValues(alpha: 0.8);
      cardBoxShadow = secondaryIconBackgroundColor;
      primaryIconBackgroundColor = Theme.of(context).colorScheme.secondaryFixed;
      bigTextColor = Theme.of(context).colorScheme.onSecondary;
    }
    informationCircleColor = bigTextColor;

    return CardLayout(
      id: booking.id,
      height: !isDetail ? 210 : 160,
      width: 250,
      colors: cardColor,
      shadowColor: cardBoxShadow,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                booking.room.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: bigTextColor,
                ),
              ),
              if (!isDetail)
                GestureDetector(
                  onTap: onInfo,
                  child: HeroIcon(
                    HeroIcons.informationCircle,
                    color: informationCircleColor,
                    size: 25,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            constraints: const BoxConstraints(maxHeight: 38),
            child: Scrollbar(
              radius: const Radius.circular(8),
              child: SingleChildScrollView(
                child: Text(
                  formatRecurrenceRule(
                    booking.start,
                    booking.end,
                    booking.recurrenceRule,
                    false,
                  ),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: smallTextColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          AutoSizeText(
            booking.reason,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: bigTextColor,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                booking.decision == Decision.pending
                    ? BookingTextConstants.pending
                    : booking.decision == Decision.approved
                        ? BookingTextConstants.confirmed
                        : BookingTextConstants.declined,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: smallTextColor,
                ),
              ),
              Text(
                '${BookingTextConstants.keysRequested}: ${booking.key ? BookingTextConstants.yes : BookingTextConstants.no}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: smallTextColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (!isDetail)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showButton)
                  GestureDetector(
                    onTap: onEdit,
                    child: CardButton(
                      color: primaryIconBackgroundColor,
                      shadowColor: Theme.of(context).shadowColor,
                      child: HeroIcon(
                        HeroIcons.pencil,
                        color: primaryIconColor,
                      ),
                    ),
                  ),
                if (showButton) const Spacer(),
                GestureDetector(
                  onTap: onCopy,
                  child: CardButton(
                    color: primaryIconBackgroundColor,
                    shadowColor: Theme.of(context).shadowColor,
                    child: HeroIcon(
                      HeroIcons.documentDuplicate,
                      color: primaryIconColor,
                    ),
                  ),
                ),
                if (isAdmin) const Spacer(),
                if (isAdmin)
                  GestureDetector(
                    onTap: onConfirm,
                    child: CardButton(
                      color: primaryIconBackgroundColor,
                      borderColor: isAdmin
                          ? booking.decision == Decision.approved
                              ? secondaryIconBackgroundColor
                              : Colors.transparent
                          : Colors.transparent,
                      shadowColor: Theme.of(context).shadowColor,
                      child: HeroIcon(
                        HeroIcons.check,
                        color: secondaryIconBackgroundColor,
                      ),
                    ),
                  ),
                if (isAdmin) const Spacer(),
                if (isAdmin)
                  GestureDetector(
                    onTap: onDecline,
                    child: CardButton(
                      color: secondaryIconBackgroundColor,
                      borderColor: isAdmin
                          ? booking.decision == Decision.declined
                              ? Theme.of(context).colorScheme.onSecondary
                              : Colors.transparent
                          : Colors.transparent,
                      shadowColor:
                          secondaryIconBackgroundColor.withValues(alpha: 0.2),
                      child: HeroIcon(
                        HeroIcons.xMark,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                if (!isAdmin) const Spacer(),
                if (!isAdmin && booking.decision == Decision.pending)
                  WaitingButton(
                    onTap: onDelete,
                    builder: (child) => CardButton(
                      color: secondaryIconBackgroundColor,
                      shadowColor:
                          secondaryIconBackgroundColor.withValues(alpha: 0.2),
                      child: child,
                    ),
                    child: HeroIcon(
                      HeroIcons.trash,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
