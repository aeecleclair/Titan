import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/booking/tools/constants.dart';
import 'package:titan/booking/ui/calendar/calendar_dialog_button.dart';
import 'package:titan/tools/functions.dart';

class CalendarDialog extends StatelessWidget {
  final Booking booking;
  final bool isManager;

  const CalendarDialog({
    super.key,
    required this.booking,
    required this.isManager,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                '${booking.room.name} - ${booking.reason}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                formatRecurrenceRule(
                  booking.start,
                  booking.end,
                  booking.recurrenceRule,
                  false,
                ),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade400,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${BookingTextConstants.bookedfor} ${booking.entity} ${BookingTextConstants.by} ${booking.applicant.getName()}",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              if (isManager) ...[
                const SizedBox(height: 10),
                const Divider(thickness: 3),
                const SizedBox(height: 10),
                if (booking.note != null)
                  Text(
                    booking.note!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                if (booking.note != null) const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CalendarDialogButton(
                      uri: 'mailto:${booking.applicant.email}',
                      icon: HeroIcons.atSymbol,
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Text(
                        booking.applicant.email.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CalendarDialogButton(
                      uri: (booking.applicant.phone != null)
                          ? 'sms:${booking.applicant.phone}'
                          : null,
                      icon: HeroIcons.chatBubbleBottomCenterText,
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Text(
                        booking.applicant.phone ??
                            BookingTextConstants.noPhoneRegistered,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          Positioned(
            top: -10,
            right: -10,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500.withValues(alpha: 0.3),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const HeroIcon(HeroIcons.xMark, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
