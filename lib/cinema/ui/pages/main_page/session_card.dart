import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/cinema/providers/scroll_provider.dart';
import 'package:myecl/cinema/providers/session_poster_map_provider.dart';
import 'package:myecl/cinema/providers/session_poster_provider.dart';
import 'package:myecl/cinema/tools/functions.dart';

class SessionCard extends HookConsumerWidget {
  final Session session;
  final int index;
  final VoidCallback onTap;
  const SessionCard(
      {Key? key,
      required this.session,
      required this.index,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scroll = ref.watch(scrollProvider);
    final sessionPosterMap = ref.watch(sessionPosterMapProvider);
    final sessionPosterMapNotifier =
        ref.watch(sessionPosterMapProvider.notifier);
    final sessionPosterNotifier = ref.watch(sessionPosterProvider.notifier);

    double minScale = 0.8;
    double scale = 1;
    double maxHeigth = MediaQuery.of(context).size.height - 344;
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
    height = maxHeigth * (1 - scale) / 2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
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
                        return Container(
                          height: maxHeigth * scale,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                image: data.first.image, fit: BoxFit.cover),
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
                      } else {
                        sessionPosterNotifier.getLogo(session.id).then((value) {
                          sessionPosterMapNotifier.setTData(
                              session, AsyncData([value]));
                        });
                        return Container(
                          height: maxHeigth * scale,
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
                        height: maxHeigth * scale,
                        width: double.infinity,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }, error: (error, stack) {
                      return SizedBox(
                        height: maxHeigth * scale,
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
                const SizedBox(
                  width: 25,
                ),
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
            const SizedBox(
              height: 10,
            ),
            Text(session.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
