import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  final Function()? onEdit, onConfirm, onDecline, onCopy, onInfo;
  final Future Function()? onDelete;
  final bool isAdmin, isDetail;
  const BookingCard(
      {super.key,
      required this.booking,
      this.onEdit,
      this.onConfirm,
      this.onDecline,
      this.onInfo,
      this.onCopy,
      this.onDelete,
      this.isAdmin = false,
      this.isDetail = false});

  @override
  Widget build(BuildContext context) {
    final showButton = booking.end.isAfter(DateTime.now());
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
        cardColor = [
          Colors.white,
          Colors.white,
        ];
        darkIconBackgroundColor = Colors.black;

        break;
      case Decision.approved:
        cardColor = [
          const Color(0xff79a400),
          const Color(0xff387200),
        ];

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
      cardBoxShadow = Colors.grey.shade200.withOpacity(0.5);
      lightIconBackgroundColor = Colors.white;
      bigTextColor = Colors.black;
    } else {
      smallTextColor = Colors.white.withOpacity(0.8);
      cardBoxShadow = darkIconBackgroundColor;
      lightIconBackgroundColor = Colors.grey.shade200;
      bigTextColor = Colors.white;
    }
    informationCircleColor = bigTextColor;

    return CardLayout(
      id: booking.id,
      height: !isDetail ? 180 : 160,
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
                )
            ],
          ),
          const SizedBox(height: 6),
          AutoSizeText(
              formatRecurrenceRule(
                  booking.start, booking.end, booking.recurrenceRule, false),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: smallTextColor)),
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
                      color: smallTextColor)),
              Text(
                  '${BookingTextConstants.keys}: ${booking.key ? BookingTextConstants.yes : BookingTextConstants.no}',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: smallTextColor)),
            ],
          ),
          const Spacer(),
          if (!isDetail)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showButton || isAdmin)
                  GestureDetector(
                    onTap: onEdit,
                    child: CardButton(
                      color: lightIconBackgroundColor,
                      shadowColor: Colors.grey.withOpacity(0.2),
                      child: HeroIcon(
                        HeroIcons.pencil,
                        color: lightIconColor,
                      ),
                    ),
                  ),
                if (showButton || isAdmin) const Spacer(),
                GestureDetector(
                  onTap: onCopy,
                  child: CardButton(
                    color: lightIconBackgroundColor,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    child: HeroIcon(
                      HeroIcons.documentDuplicate,
                      color: lightIconColor,
                    ),
                  ),
                ),
                if (showButton && isAdmin) const Spacer(),
                if (showButton && isAdmin)
                  GestureDetector(
                    onTap: onConfirm,
                    child: CardButton(
                      color: lightIconBackgroundColor,
                      borderColor: isAdmin
                          ? booking.decision == Decision.approved
                              ? darkIconBackgroundColor
                              : Colors.transparent
                          : Colors.transparent,
                      shadowColor: Colors.grey.withOpacity(0.2),
                      child: HeroIcon(HeroIcons.check,
                          color: darkIconBackgroundColor),
                    ),
                  ),
                if (showButton && isAdmin) const Spacer(),
                if (showButton && isAdmin)
                  GestureDetector(
                    onTap: onDecline,
                    child: CardButton(
                      color: darkIconBackgroundColor,
                      borderColor: isAdmin
                          ? booking.decision == Decision.declined
                              ? Colors.white
                              : Colors.transparent
                          : Colors.transparent,
                      shadowColor: darkIconBackgroundColor.withOpacity(0.2),
                      child:
                          const HeroIcon(HeroIcons.xMark, color: Colors.white),
                    ),
                  ),
                if (!isAdmin) const Spacer(),
                if (!isAdmin)
                  WaitingButton(
                    onTap: onDelete,
                    builder: (child) => CardButton(
                        color: darkIconBackgroundColor,
                        shadowColor: darkIconBackgroundColor.withOpacity(0.2),
                        child: child),
                    child: const HeroIcon(HeroIcons.trash, color: Colors.white),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
