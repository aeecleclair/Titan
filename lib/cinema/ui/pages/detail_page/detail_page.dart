import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/providers/session_poster_map_provider.dart';
import 'package:myecl/cinema/providers/session_poster_provider.dart';
import 'package:myecl/cinema/providers/session_provider.dart';
import 'package:myecl/cinema/tools/constants.dart';
import 'package:myecl/cinema/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:qlevar_router/qlevar_router.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final sessionPosterMap = ref.watch(sessionPosterMapProvider);
    final sessionPosterMapNotifier =
        ref.watch(sessionPosterMapProvider.notifier);
    final sessionPosterNotifier = ref.watch(sessionPosterProvider.notifier);
    final List<String> genres = session.genre != null
        ? session.genre!.split(',').map((e) => e.trim()).toList()
        : [];
    return Stack(
      children: [
        Stack(
          children: [
            sessionPosterMap.when(
                data: (data) {
                  if (data[session] != null) {
                    return data[session]!.when(data: (data) {
                      if (data.isNotEmpty) {
                        return Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(0, 5),
                            ),
                          ]),
                          child: Image(
                            image: data.first.image,
                            fit: BoxFit.fill,
                          ),
                        );
                      } else {
                        Future.delayed(const Duration(milliseconds: 1), () {
                          sessionPosterMapNotifier.setTData(
                              session, const AsyncLoading());
                        });
                        tokenExpireWrapper(ref, () async {
                          sessionPosterNotifier
                              .getLogo(session.id)
                              .then((value) {
                            sessionPosterMapNotifier.setTData(
                                session, AsyncData([value]));
                          });
                        });
                        return Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(0, 5),
                            ),
                          ]),
                        );
                      }
                    }, loading: () {
                      return const SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }, error: (error, stack) {
                      return const SizedBox(
                        width: double.infinity,
                        child: Center(
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
          ],
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 45,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: QR.back,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: const Offset(0, 5),
                            ),
                          ]),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
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
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 140,
              ),
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color.fromARGB(0, 255, 255, 255),
                      Colors.grey.shade50.withOpacity(0.85),
                      Colors.grey.shade50,
                    ],
                    stops: const [0.0, 0.65, 1.0],
                  ),
                ),
              ),
              Container(
                color: Colors.grey.shade50,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        session.name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      alignment: Alignment.center,
                      child: Text(
                        formatDate(session.start),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 35,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: genres.length + 2,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0 || index == genres.length + 1) {
                            return const SizedBox(
                              width: 20,
                            );
                          } else {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Text(
                                genres[index - 1],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        session.overview != null
                            ? session.overview!
                            : CinemaTextConstants.noOverview,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
