import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/cinema/providers/cinema_topic_provider.dart';
import 'package:myecl/cinema/providers/scroll_provider.dart';
import 'package:myecl/cinema/providers/session_poster_map_provider.dart';
import 'package:myecl/cinema/providers/session_poster_provider.dart';
import 'package:myecl/cinema/tools/constants.dart';
import 'package:myecl/cinema/tools/functions.dart';
import 'package:myecl/drawer/providers/is_web_format_provider.dart';
import 'package:myecl/service/class/message.dart';
import 'package:myecl/service/local_notification_service.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class SessionCard extends HookConsumerWidget {
  final Session session;
  final int index;
  final VoidCallback onTap;
  const SessionCard(
      {super.key,
      required this.session,
      required this.index,
      required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scroll = ref.watch(scrollProvider);
    final sessionPosterMap = ref.watch(sessionPosterMapProvider);
    final sessionPosterMapNotifier =
        ref.watch(sessionPosterMapProvider.notifier);
    final sessionPosterNotifier = ref.watch(sessionPosterProvider.notifier);
    final isWebFormat = ref.watch(isWebFormatProvider);
    final cinemaTopics = ref.watch(cinemaTopicsProvider);
    final localNotificationService = LocalNotificationService();
    final selected = cinemaTopics.maybeWhen(
        data: (data) => data.contains(session.id), orElse: () => false);

    final sessionNotificationStartTime =
        session.start.subtract(const Duration(minutes: 10));

    double minScale = 0.8;
    double scale = 1;
    double maxHeight = MediaQuery.of(context).size.height - 344;
    double height = 0;

    int scrollValue = scroll.floor();

    if (index == scrollValue) {
      scale = 1 - (scroll - index) * (1 - minScale);
    } else if (index == scrollValue + 1) {
      scale = minScale + (scroll - index + 1) * (1 - minScale);
    } else if (index == scrollValue - 1) {
      scale = minScale + (scroll - index - 1) * (1 - minScale);
    } else {
      scale = minScale;
    }
    height = maxHeight * (1 - scale) / 2;

    void createSessionNotification(Session session) {
      localNotificationService.showNotification(Message(
          actionModule: '',
          actionTable: '',
          content: 'La séance '
              '${session.name}'
              ' commence dans 10 minutes',
          context: session.id,
          isVisible: true,
          title: 'Cinéma',
          deliveryDateTime: sessionNotificationStartTime));
    }

    /* Setting the notification if the session is selected but no notification is pending,
     * this situation exists when the enable the notification from another device
     * */
    // if (selected) {
    //   localNotificationService
    //       .getNotificationDetail(session.id)
    //       .then((scheduledNotification) {
    //     if (scheduledNotification == null) {
    //       createSessionNotification(session);
    //     } else {
    //       final message =
    //           Message.fromJson(jsonDecode(scheduledNotification.payload!));
    //       if (!message.deliveryDateTime!
    //           .isAtSameMomentAs(sessionNotificationStartTime)) {
    //         localNotificationService.cancelNotificationById(session.id);
    //         createSessionNotification(session);
    //       }
    //     }
    //   });
    // }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.all(isWebFormat ? 50 : 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height,
            ),
            sessionPosterMap.when(
                data: (data) {
                  if (data[session] != null) {
                    return data[session]!.when(data: (data) {
                      if (data.isNotEmpty) {
                        return isWebFormat
                            ? Container(
                                height: maxHeight * scale,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: AspectRatio(
                                        aspectRatio: 2 / 3,
                                        child: Image(
                                          image: data.first.image,
                                          fit: BoxFit.cover, // use this
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(session.name,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(formatDate(session.start),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(formatDuration(session.duration),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              session.overview ??
                                                  CinemaTextConstants
                                                      .noOverview,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              )),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                  ],
                                ),
                              )
                            : Stack(
                                children: [
                                  Container(
                                    height: maxHeight * scale,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                            image: data.first.image,
                                            fit: BoxFit.cover),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                        border: (selected &&
                                                session.start
                                                    .isAfter(DateTime.now()))
                                            ? Border.all(
                                                color: Colors.black, width: 3)
                                            : null),
                                  ),
                                  if (selected &&
                                      session.start.isAfter(DateTime.now()))
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        width: 80,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            )),
                                        child: const Center(
                                          child: HeroIcon(
                                            HeroIcons.bell,
                                            size: 30,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                      } else {
                        Future.delayed(const Duration(milliseconds: 1), () {
                          sessionPosterMapNotifier.setTData(
                              session, const AsyncLoading());
                        });
                        tokenExpireWrapper(ref, () async {
                          final image =
                              await sessionPosterNotifier.getLogo(session.id);
                          sessionPosterMapNotifier.setTData(
                              session, AsyncData([image]));
                        });
                        return Container(
                          height: maxHeight * scale,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        );
                      }
                    }, loading: () {
                      return SizedBox(
                        height: maxHeight * scale,
                        width: double.infinity,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }, error: (error, stack) {
                      return SizedBox(
                        height: maxHeight * scale,
                        width: double.infinity,
                        child: const Center(
                          child: HeroIcon(HeroIcons.exclamationCircle),
                        ),
                      );
                    });
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error $error')),
            const SizedBox(
              height: 15,
            ),
            if (!isWebFormat)
              Column(
                children: [
                  Text(session.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeroIcon(
                        HeroIcons.calendar,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(formatDate(session.start),
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeroIcon(
                        HeroIcons.clock,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(formatDuration(session.duration),
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
