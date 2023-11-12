import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/booking/ui/calendar/admin_details.dart';

class CalendarDialog extends StatelessWidget {
  final Booking booking;
  final bool isManager;

  const CalendarDialog(
      {super.key, required this.booking, required this.isManager});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          isManager
              ? AdminDetails(booking: booking)
              : Container(
                  height: 220 + (booking.note.length / 30 - 5) * 15,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        '${booking.room.name} - ${booking.reason}',
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formatDates(
                          booking.start,
                          booking.end,
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
                        "${BookingTextConstants.bookedfor} ${booking.entity}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ],
                  ),
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
                          color: Colors.grey.shade500.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 1)
                    ],
                    borderRadius: BorderRadius.circular(15)),
                child: const HeroIcon(
                  HeroIcons.xMark,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
