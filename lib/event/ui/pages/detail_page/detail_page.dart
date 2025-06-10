import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/event/providers/event_provider.dart';
import 'package:titan/event/tools/constants.dart';
import 'package:titan/event/ui/event.dart';
import 'package:titan/event/ui/components/event_ui.dart';
import 'package:titan/tools/functions.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends HookConsumerWidget {
  final bool isAdmin;
  const DetailPage({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(eventProvider);

    void displayToastWithoutContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    return EventTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Padding(
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
                                event.organizer,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                event.description,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              if (isAdmin)
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        try {
                                          await launchUrl(
                                            Uri.parse(
                                              'mailto:${event.applicant.email}',
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
                                        event.applicant.email.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Text(
                                      event.applicant.phone ??
                                          EventTextConstants.noPhoneRegistered,
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                    const SizedBox(height: 50),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            if (event.applicant.phone != null) {
                                              try {
                                                await launchUrl(
                                                  Uri.parse(
                                                    'tel:${event.applicant.phone}',
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
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            padding: const EdgeInsets.all(15.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                              color: Colors.grey.shade50,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withValues(
                                                    alpha: 0.2,
                                                  ),
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
                                        const Spacer(flex: 5),
                                        GestureDetector(
                                          onTap: () async {
                                            if (event.applicant.phone != null) {
                                              try {
                                                await launchUrl(
                                                  Uri.parse(
                                                    'sms:${event.applicant.phone}',
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
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            padding: const EdgeInsets.all(15.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                              color: Colors.grey.shade50,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withValues(
                                                    alpha: 0.2,
                                                  ),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 10),
                                                ),
                                              ],
                                            ),
                                            child: const HeroIcon(
                                              HeroIcons
                                                  .chatBubbleBottomCenterText,
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: EventUi(event: event, isDetailPage: true)),
            ),
          ],
        ),
      ),
    );
  }
}
