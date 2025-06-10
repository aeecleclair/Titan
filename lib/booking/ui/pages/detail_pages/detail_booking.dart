import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/booking/providers/booking_provider.dart';
import 'package:titan/booking/tools/constants.dart';
import 'package:titan/booking/tools/functions.dart';
import 'package:titan/booking/ui/booking.dart';
import 'package:titan/booking/ui/components/booking_card.dart';
import 'package:titan/booking/ui/pages/detail_pages/contact_button.dart';
import 'package:titan/tools/functions.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBookingPage extends HookConsumerWidget {
  final bool isAdmin;
  const DetailBookingPage({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingProvider);

    void displayToastWithoutContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    return BookingTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade50,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        Container(
                          padding: const EdgeInsets.all(30.0),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                decisionToString(booking.decision),
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (booking.note != null)
                                const SizedBox(height: 10),
                              if (booking.note != null)
                                Text(
                                  booking.note!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        if (isAdmin)
                          Column(
                            children: [
                              AutoSizeText(
                                booking.applicant.getName(),
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    await launchUrl(
                                      Uri.parse(
                                        'mailto:${booking.applicant.email}',
                                      ),
                                    );
                                  } catch (e) {
                                    displayToastWithoutContext(
                                      TypeMsg.error,
                                      e.toString(),
                                    );
                                  }
                                },
                                child: Text(
                                  booking.applicant.email.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              if (booking.entity.isNotEmpty)
                                Column(
                                  children: [
                                    AutoSizeText(
                                      "${BookingTextConstants.bookedfor} ${booking.entity}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 50),
                              Text(
                                booking.applicant.phone ??
                                    BookingTextConstants.noPhoneRegistered,
                                style: const TextStyle(fontSize: 25),
                              ),
                              const SizedBox(height: 50),
                              Row(
                                children: [
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () async {
                                      if (booking.applicant.phone != null) {
                                        try {
                                          await launchUrl(
                                            Uri.parse(
                                              'tel:${booking.applicant.phone}',
                                            ),
                                          );
                                        } catch (e) {
                                          displayToastWithoutContext(
                                            TypeMsg.error,
                                            e.toString(),
                                          );
                                        }
                                      }
                                    },
                                    child: const ContactButton(
                                      child: HeroIcon(
                                        HeroIcons.phone,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const Spacer(flex: 2),
                                  GestureDetector(
                                    onTap: () async {
                                      if (booking.applicant.phone != null) {
                                        try {
                                          await launchUrl(
                                            Uri.parse(
                                              'sms:${booking.applicant.phone}',
                                            ),
                                          );
                                        } catch (e) {
                                          displayToastWithoutContext(
                                            TypeMsg.error,
                                            e.toString(),
                                          );
                                        }
                                      }
                                    },
                                    child: const ContactButton(
                                      child: HeroIcon(
                                        HeroIcons.chatBubbleBottomCenterText,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: BookingCard(booking: booking, isDetail: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
