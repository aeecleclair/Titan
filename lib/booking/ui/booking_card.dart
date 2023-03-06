import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class BookingCard extends HookConsumerWidget {
  final Booking booking;
  final Function() onEdit, onConfirm, onDecline, onCopy, onInfo;
  final Future Function() onDelete;
  final bool isAdmin, isDetail;
  const BookingCard(
      {super.key,
      required this.booking,
      required this.onEdit,
      required this.onConfirm,
      required this.onDecline,
      required this.onInfo,
      required this.onCopy,
      required this.onDelete,
      required this.isAdmin,
      required this.isDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showButton = booking.start.isAfter(DateTime.now());
    return Container(
      padding: const EdgeInsets.all(15.0),
      height: ((showButton || isAdmin) && !isDetail) ? 210 : 200,
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(booking.room.name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  if (!isDetail)
                    GestureDetector(
                      onTap: onInfo,
                      child: const HeroIcon(HeroIcons.informationCircle,
                          color: Colors.black, size: 25),
                    )
                ],
              ),
              const SizedBox(height: 6),
              AutoSizeText(
                  formatRecurrenceRule(booking.start, booking.end,
                      booking.recurrenceRule, false),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400)),
              const SizedBox(height: 4),
              AutoSizeText(booking.reason,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
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
                          color: Colors.grey.shade400)),
                  Text(
                      '${BookingTextConstants.keys}: ${booking.key ? BookingTextConstants.yes : BookingTextConstants.no}',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400)),
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
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: const HeroIcon(HeroIcons.pencil,
                              color: Colors.black),
                        ),
                      ),
                    if (showButton || isAdmin) const Spacer(),
                    GestureDetector(
                      onTap: onCopy,
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(2, 3))
                          ],
                        ),
                        child: const HeroIcon(HeroIcons.documentDuplicate,
                            color: Colors.white),
                      ),
                    ),
                    if (showButton && isAdmin) const Spacer(),
                    if (showButton && isAdmin)
                      GestureDetector(
                        onTap: onConfirm,
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: isAdmin
                                    ? booking.decision == Decision.approved
                                        ? Colors.black
                                        : Colors.transparent
                                    : Colors.transparent,
                                width: 2),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: const HeroIcon(HeroIcons.check,
                              color: Colors.black),
                        ),
                      ),
                    if (showButton && isAdmin) const Spacer(),
                    if (showButton && isAdmin)
                      GestureDetector(
                        onTap: onDecline,
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: isAdmin
                                    ? booking.decision == Decision.declined
                                        ? Colors.white
                                        : Colors.transparent
                                    : Colors.transparent,
                                width: 2),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: const HeroIcon(HeroIcons.xMark,
                              color: Colors.white),
                        ),
                      ),
                    if (!isAdmin) const Spacer(),
                    if (!isAdmin)
                      ShrinkButton(
                        onTap: onDelete,
                        waitChild: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(2, 3))
                            ],
                          ),
                          child: const HeroIcon(HeroIcons.trash,
                              color: Colors.white),
                        ),
                      ),
                  ],
                ),
              if (!isDetail) const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
