import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminDetails extends StatelessWidget {
  final Booking booking;

  const AdminDetails({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    void displayToastWithoutContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    return Container(
      margin: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            booking.applicant.getName(),
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () async {
              try {
                await launchUrl(Uri.parse('mailto:${booking.applicant.email}'));
              } catch (e) {
                displayToastWithoutContext(TypeMsg.error, e.toString());
              }
            },
            child: Text(
              booking.applicant.email,
              style: const TextStyle(
                fontSize: 16,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          if (booking.entity.isNotEmpty)
            AutoSizeText(
              "${BookingTextConstants.bookedfor} ${booking.entity}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(
            height: 50,
          ),
          Text(
            booking.applicant.phone ?? BookingTextConstants.noPhoneRegistered,
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  if (booking.applicant.phone != null) {
                    try {
                      await launchUrl(
                          Uri.parse('tel:${booking.applicant.phone}'));
                    } catch (e) {
                      displayToastWithoutContext(TypeMsg.error, e.toString());
                    }
                  }
                },
                child: Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
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
                    HeroIcons.phone,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 100),
              GestureDetector(
                onTap: () async {
                  if (booking.applicant.phone != null) {
                    try {
                      await launchUrl(
                          Uri.parse('sms:${booking.applicant.phone}'));
                    } catch (e) {
                      displayToastWithoutContext(TypeMsg.error, e.toString());
                    }
                  }
                },
                child: Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
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
            ],
          ),
        ],
      ),
    );
  }
}
