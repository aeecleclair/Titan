import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/cinema/class/session.dart';
import 'package:titan/cinema/providers/cinema_topic_provider.dart';
import 'package:titan/cinema/providers/scroll_provider.dart';
import 'package:titan/cinema/providers/session_poster_map_provider.dart';
import 'package:titan/cinema/providers/session_poster_provider.dart';
import 'package:titan/cinema/tools/constants.dart';
import 'package:titan/cinema/tools/functions.dart';
import 'package:titan/drawer/providers/is_web_format_provider.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';

class SessionCard extends HookConsumerWidget {
  final Session session;
  final int index;
  final VoidCallback? onTap;
  const SessionCard({
    super.key,
    required this.session,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scroll = ref.watch(scrollProvider);
    final sessionPoster = ref.watch(
      sessionPosterMapProvider.select((value) => value[session.id]),
    );
    final sessionPosterMapNotifier = ref.watch(
      sessionPosterMapProvider.notifier,
    );
    final sessionPosterNotifier = ref.watch(sessionPosterProvider.notifier);
    final isWebFormat = ref.watch(isWebFormatProvider);
    final cinemaTopics = ref.watch(cinemaTopicsProvider);
    final selected = cinemaTopics.maybeWhen(
      data: (data) => data.contains(session.id),
      orElse: () => false,
    );

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

    // void createSessionNotification(Session session) {
    //   localNotificationService.showNotification(Message(
    //       actionModule: '',
    //       actionTable: '',
    //       content: 'La séance '
    //           '${session.name}'
    //           ' commence dans 10 minutes',
    //       context: session.id,
    //       isVisible: true,
    //       title: 'Cinéma',
    //       deliveryDateTime: sessionNotificationStartTime));
    // }

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
            SizedBox(height: height),
            Container(
              height: maxHeight * scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: AutoLoaderChild(
                group: sessionPoster,
                notifier: sessionPosterMapNotifier,
                mapKey: session.id,
                loader: (sessionId) => sessionPosterNotifier.getLogo(sessionId),
                dataBuilder: (context, data) {
                  return isWebFormat
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              const SizedBox(width: 50),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      session.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      formatDate(session.start),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      formatDuration(session.duration),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      session.overview ??
                                          CinemaTextConstants.noOverview,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 50),
                            ],
                          ),
                        )
                      : Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: data.first.image,
                                  fit: BoxFit.cover,
                                ),
                                border:
                                    (selected &&
                                        session.start.isAfter(DateTime.now()))
                                    ? Border.all(color: Colors.black, width: 3)
                                    : null,
                              ),
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
                                    ),
                                  ),
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
                },
                errorBuilder: (error, stack) =>
                    const Center(child: HeroIcon(HeroIcons.exclamationCircle)),
              ),
            ),
            const SizedBox(height: 15),
            if (!isWebFormat)
              Column(
                children: [
                  Text(
                    session.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeroIcon(HeroIcons.calendar, size: 20),
                      const SizedBox(width: 7),
                      Text(
                        formatDate(session.start),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeroIcon(HeroIcons.clock, size: 20),
                      const SizedBox(width: 7),
                      Text(
                        formatDuration(session.duration),
                        style: const TextStyle(fontSize: 16),
                      ),
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
