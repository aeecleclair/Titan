import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarDialog extends StatelessWidget {
  final Booking booking;
  final bool isManager;

  const CalendarDialog(
      {super.key, required this.booking, required this.isManager});

  @override
  Widget build(BuildContext context) {
    void displayToastWithoutContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                    formatRecurrenceRule(booking.start, booking.end,
                        booking.recurrenceRule, false),
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
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  if (isManager) ...[
                    const Divider(
                      thickness: 3,
                    ),
                    Text(
                      booking.note,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${BookingTextConstants.bookedBy} ${booking.applicant.getName()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              await launchUrl(
                                Uri.parse('mailto:${booking.applicant.email}'),
                              );
                            } catch (e) {
                              displayToastWithoutContext(
                                  TypeMsg.error, e.toString());
                            }
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              color: Colors.grey.shade50,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const HeroIcon(
                              HeroIcons.atSymbol,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          booking.applicant.email,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (booking.applicant.phone != null) {
                              try {
                                await launchUrl(Uri.parse(
                                    'sms:${booking.applicant.phone}'));
                              } catch (e) {
                                displayToastWithoutContext(
                                    TypeMsg.error, e.toString());
                              }
                            }
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              color: Colors.grey.shade50,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const HeroIcon(
                              HeroIcons.chatBubbleBottomCenterText,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          booking.applicant.phone ??
                              BookingTextConstants.noPhoneRegistered,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
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
                      spreadRadius: 1,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
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
