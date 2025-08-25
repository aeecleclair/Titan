import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:titan/l10n/app_localizations.dart';

class BookingCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isNotEnded = booking.recurrenceRule.isNotEmpty
        ? SfCalendar.parseRRule(
            booking.recurrenceRule,
            booking.start,
          ).endDate!.isAfter(DateTime.now())
        : booking.end.isAfter(DateTime.now());
    final showButton =
        (isNotEnded && booking.decision == Decision.pending) || isAdmin;
    final List<Color> cardColor;
    final Color smallTextColor;
    final Color bigTextColor;
    final Color darkIconBackgroundColor;
    final Color lightIconBackgroundColor;
    final Color lightIconColor;
    final Color cardBoxShadow;
    final Color informationCircleColor;

    switch (booking.decision) {
      case Decision.pending:
        cardColor = [Colors.white, Colors.white];
        darkIconBackgroundColor = Colors.black;

        break;
      case Decision.approved:
        cardColor = [const Color(0xff79a400), const Color(0xff387200)];

        darkIconBackgroundColor = const Color.fromARGB(255, 26, 53, 0);
        break;
      case Decision.declined:
        cardColor = [
          const Color.fromARGB(255, 250, 66, 38),
          const Color.fromARGB(255, 172, 32, 10),
        ];
        darkIconBackgroundColor = const Color.fromARGB(255, 99, 13, 0);
        break;
    }

    lightIconColor = darkIconBackgroundColor;

    if (booking.decision == Decision.pending) {
      smallTextColor = Colors.grey.shade400;
      cardBoxShadow = Colors.grey.shade200.withValues(alpha: 0.5);
      lightIconBackgroundColor = Colors.white;
      bigTextColor = Colors.black;
    } else {
      smallTextColor = Colors.white.withValues(alpha: 0.8);
      cardBoxShadow = darkIconBackgroundColor;
      lightIconBackgroundColor = Colors.grey.shade200;
      bigTextColor = Colors.white;
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
                    locale.toString()
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
                    ? AppLocalizations.of(context)!.bookingPending
                    : booking.decision == Decision.approved
                    ? AppLocalizations.of(context)!.bookingConfirmed
                    : AppLocalizations.of(context)!.bookingDeclined,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: smallTextColor,
                ),
              ),
              Text(
                '${AppLocalizations.of(context)!.bookingKeysRequested}: ${booking.key ? AppLocalizations.of(context)!.bookingYes : AppLocalizations.of(context)!.bookingNo}',
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
                      color: lightIconBackgroundColor,
                      shadowColor: Colors.grey.withValues(alpha: 0.2),
                      child: HeroIcon(HeroIcons.pencil, color: lightIconColor),
                    ),
                  ),
                if (showButton) const Spacer(),
                GestureDetector(
                  onTap: onCopy,
                  child: CardButton(
                    color: lightIconBackgroundColor,
                    shadowColor: Colors.grey.withValues(alpha: 0.2),
                    child: HeroIcon(
                      HeroIcons.documentDuplicate,
                      color: lightIconColor,
                    ),
                  ),
                ),
                if (isAdmin) const Spacer(),
                if (isAdmin)
                  GestureDetector(
                    onTap: onConfirm,
                    child: CardButton(
                      color: lightIconBackgroundColor,
                      borderColor: isAdmin
                          ? booking.decision == Decision.approved
                                ? darkIconBackgroundColor
                                : Colors.transparent
                          : Colors.transparent,
                      shadowColor: Colors.grey.withValues(alpha: 0.2),
                      child: HeroIcon(
                        HeroIcons.check,
                        color: darkIconBackgroundColor,
                      ),
                    ),
                  ),
                if (isAdmin) const Spacer(),
                if (isAdmin)
                  GestureDetector(
                    onTap: onDecline,
                    child: CardButton(
                      color: darkIconBackgroundColor,
                      borderColor: isAdmin
                          ? booking.decision == Decision.declined
                                ? Colors.white
                                : Colors.transparent
                          : Colors.transparent,
                      shadowColor: darkIconBackgroundColor.withValues(
                        alpha: 0.2,
                      ),
                      child: const HeroIcon(
                        HeroIcons.xMark,
                        color: Colors.white,
                      ),
                    ),
                  ),
                if (!isAdmin) const Spacer(),
                if (!isAdmin && booking.decision == Decision.pending)
                  WaitingButton(
                    onTap: onDelete,
                    builder: (child) => CardButton(
                      color: darkIconBackgroundColor,
                      shadowColor: darkIconBackgroundColor.withValues(
                        alpha: 0.2,
                      ),
                      child: child,
                    ),
                    child: const HeroIcon(HeroIcons.trash, color: Colors.white),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
