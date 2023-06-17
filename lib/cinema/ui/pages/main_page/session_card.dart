import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/cinema/providers/scroll_provider.dart';
import 'package:myecl/cinema/providers/session_poster_map_provider.dart';
import 'package:myecl/cinema/providers/session_poster_provider.dart';
import 'package:myecl/cinema/tools/constants.dart';
import 'package:myecl/cinema/tools/functions.dart';
import 'package:myecl/drawer/providers/is_web_format_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

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
    final isWebFormat = ref.watch(isWebFormatProvider);

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
        padding: EdgeInsets.all(isWebFormat ? 50: 0),
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
                                height: maxHeigth * scale,
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
                            : Container(
                                height: maxHeigth * scale,
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
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                              );
                      } else {
                        Future.delayed(const Duration(milliseconds: 100), () {
                          sessionPosterMapNotifier.setTData(
                                  session, const AsyncLoading());
                        });
                        tokenExpireWrapper(ref, () async {
                          sessionPosterNotifier.getLogo(session.id).then((value) {
                            sessionPosterMapNotifier.setTData(
                                session, AsyncData([value]));
                          });
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
